import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/book_list_tile.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:spimo/features/memos/presentation/controller/memos_controller.dart';

class RecordHomeScreen extends ConsumerStatefulWidget {
  const RecordHomeScreen({Key? key}) : super(key: key);

  @override
  RecordHomeScreenState createState() => RecordHomeScreenState();
}

class RecordHomeScreenState extends ConsumerState<RecordHomeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  List<MemoText> _wordList = [];
  String _currentLocaleId = '';
  bool _isAccent = false;
  int? _startPage;
  int? _endPage;

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
    if (_lastWords != '') {
      _wordList.add(addedText);
    }
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundGray,
        appBar: CommonAppBar(context: context, title: 'Record'),
        body: currentBook == null
            ? const Text('no data')
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: BookListTile(
                        book: currentBook,
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
                    Expanded(
                      child: ColoredBox(
                        color: white,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _wordList.length,
                          itemBuilder: (context, index) {
                            final text = _wordList[index].text;
                            final color = _wordList[index].textColor.color;
                            return Text(
                              text,
                              style: TextStyle(color: color),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed: _speechToText.isListening || _wordList.isEmpty
                          ? null
                          : () async {
                              final memo = Memo(
                                  id: 'id',
                                  contents: _wordList,
                                  startPage: _startPage,
                                  endPage: _endPage,
                                  bookId: currentBook.id,
                                  createdAt: DateTime.now());
                              ref
                                  .read(memosControllerProvider.notifier)
                                  .addMemo(memo: memo);
                              _lastWords = '';
                              _wordList = [];
                            },
                      child: const Text('保存'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: '開始ページ',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _startPage = int.tryParse(value);
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: '終了ページ',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _endPage = int.tryParse(value);
                                });
                              },
                            ),
                          ),
                          CupertinoSwitch(
                            value: _isAccent,
                            onChanged: (value) {
                              setState(() {
                                _isAccent = value;
                              });
                            },
                          ),
                          const SizedBox(width: 80),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: accent,
          onPressed:
              _speechToText.isNotListening ? _startListening : _stopListening,
          tooltip: 'Listen',
          child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
