import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';
import 'package:spimo/util/converter/string_to_color_conberter.dart';

class RecordHomeScreen extends ConsumerStatefulWidget {
  const RecordHomeScreen({Key? key}) : super(key: key);

  @override
  RecordHomeScreenState createState() => RecordHomeScreenState();
}

class RecordHomeScreenState extends ConsumerState<RecordHomeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  List<MemoText> wordList = [];
  String _currentLocaleId = '';
  bool _isAccent = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    var systemLocale = await _speechToText.systemLocale();
    _currentLocaleId = systemLocale?.localeId ?? '';
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: _currentLocaleId,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    final TextColor textColor = _isAccent ? TextColor.red : TextColor.black;
    final MemoText addedText = MemoText(text: _lastWords, textColor: textColor);
    wordList.add(addedText);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentBook = ref.watch(currentBookControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('spiMo'),
      ),
      body: AsyncValueWidget(
          value: currentBook,
          data: (book) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  book != null
                      ? BookListTile(book: book)
                      : const SizedBox.shrink(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Recognized words:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _speechToText.isListening
                          ? _lastWords
                          : _speechEnabled
                              ? 'Tap the microphone to start listening...'
                              : 'Speech not available',
                    ),
                  ),
                  CupertinoSwitch(
                      value: _isAccent,
                      onChanged: (value) {
                        setState(() {
                          _isAccent = value;
                        });
                      }),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: wordList.length,
                    itemBuilder: (context, index) {
                      final text = wordList[index].text;
                      final color = wordList[index].textColor.color;
                      return Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      final memo = Memo(
                          id: 'id',
                          contents: wordList,
                          bookId: book!.id,
                          createdAt: DateTime.now());
                      ref.read(memoStorageProvider).addMemo(memo);
                    },
                    child: const Text('保存'),
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}
