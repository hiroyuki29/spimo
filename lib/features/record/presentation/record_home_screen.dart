import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spimo/common_widget/app_bar/common_app_bar.dart';
import 'package:spimo/common_widget/async_value/async_value_widget.dart';
import 'package:spimo/common_widget/color/color.dart';
import 'package:spimo/common_widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common_widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/current_book_card.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  void _startListening({required bool isAccent}) async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: _currentLocaleId,
    );
    setState(() {
      _isAccent = isAccent;
    });
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
    final currentBookController =
        ref.watch(currentBookControllerProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundGray,
        appBar: CommonAppBar(context: context, title: 'Record'),
        body: AsyncValueWidget(
          value: currentBook,
          data: (book) {
            return book == null
                ? const NoSelectedBookWidget()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                          child: CurrentBookCard(
                            isSelected: false,
                            book: book,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _speechToText.isListening
                                ? _lastWords
                                : _speechEnabled
                                    ? AppLocalizations.of(context)!.startRecord
                                    : AppLocalizations.of(context)!
                                        .disableRecord,
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
                        sizedBoxH32,
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                            ),
                            onPressed: _speechToText.isListening ||
                                    _wordList.isEmpty ||
                                    _startPage == null
                                ? null
                                : () async {
                                    final memo = Memo(
                                      id: 'id',
                                      contents: _wordList,
                                      startPage: _startPage!,
                                      endPage: _endPage ?? _startPage!,
                                      bookId: book.id,
                                      createdAt: DateTime.now(),
                                      isTitle: false,
                                    );
                                    currentBookController.addMemo(
                                      bookId: book.id,
                                      memo: memo,
                                    );
                                    setState(() {
                                      _lastWords = '';
                                      _wordList = [];
                                    });
                                  },
                            child: Text(AppLocalizations.of(context)!.save),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: PageSetForm(
                                  title:
                                      AppLocalizations.of(context)!.startPage,
                                  onChange: (value) {
                                    setState(() {
                                      _startPage = int.tryParse(value);
                                    });
                                  },
                                ),
                              ),
                              sizedBoxW24,
                              SizedBox(
                                width: 80,
                                child: PageSetForm(
                                  title: AppLocalizations.of(context)!.endPage,
                                  onChange: (value) {
                                    setState(() {
                                      _endPage = int.tryParse(value);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 80),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
        floatingActionButton: _speechToText.isListening
            ? Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 10),
                child: SizedBox(
                  height: 60,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: _stopListening,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                    ),
                    child: Text(
                      'Stop',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: white),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'red_btn',
                      backgroundColor: Colors.red,
                      onPressed: () => _startListening(isAccent: true),
                      tooltip: 'Listen',
                      child: const Icon(Icons.mic),
                    ),
                    sizedBoxW24,
                    FloatingActionButton(
                      heroTag: 'black_btn',
                      backgroundColor: primaryDark,
                      onPressed: () => _startListening(isAccent: false),
                      tooltip: 'Listen',
                      child: const Icon(Icons.mic),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class PageSetForm extends StatelessWidget {
  const PageSetForm({
    Key? key,
    required this.onChange,
    required this.title,
  }) : super(key: key);

  final void Function(String) onChange;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      keyboardType: TextInputType.number,
      onChanged: onChange,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
