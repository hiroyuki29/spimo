import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spimo/common/widget/app_bar/common_app_bar.dart';
import 'package:spimo/common/widget/async_value/async_value_widget.dart';
import 'package:spimo/common/widget/color/color.dart';
import 'package:spimo/common/widget/compornent/no_data_display_widget.dart';
import 'package:spimo/common/widget/sized_box/constant_sized_box.dart';
import 'package:spimo/features/books/presentation/controller/current_book_controller.dart';
import 'package:spimo/features/books/presentation/ui_compornent/current_book_card.dart';
import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spimo/routing/app_router.dart';

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
  // int? _startPage;
  final TextEditingController _startPageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _startPageController.dispose();
    super.dispose();
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
        appBar: CommonAppBar(
          context: context,
          title: 'Record',
          action: IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.introduction.name);
            },
            icon: const Icon(Icons.info_outline),
          ),
        ),
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
                                    _startPageController.text == ''
                                ? null
                                : () async {
                                    final memo = Memo(
                                      id: 'id',
                                      contents: _wordList,
                                      startPage: int.tryParse(
                                              _startPageController.text) ??
                                          0,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                child: PageSetForm(
                                  controller: _startPageController,
                                  title:
                                      AppLocalizations.of(context)!.startPage,
                                ),
                              ),
                              sizedBoxW8,
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    PageChangeButton(
                                      icon: Icons.add,
                                      onTap: () {
                                        final currentPage = int.tryParse(
                                                _startPageController.text) ??
                                            0;
                                        final increasedPage = currentPage + 1;
                                        setState(() {
                                          _startPageController.text =
                                              increasedPage.toString();
                                        });
                                      },
                                    ),
                                    PageChangeButton(
                                      icon: Icons.remove,
                                      onTap: () {
                                        final currentPage = int.tryParse(
                                                _startPageController.text) ??
                                            0;
                                        if (currentPage < 1) return;
                                        final decreasedPage = currentPage - 1;
                                        setState(() {
                                          _startPageController.text =
                                              decreasedPage.toString();
                                        });
                                      },
                                    ),
                                  ],
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
        floatingActionButton: Visibility(
          visible: currentBook.hasValue && currentBook.value != null,
          child: _speechToText.isListening
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
      ),
    );
  }
}

class PageChangeButton extends StatelessWidget {
  const PageChangeButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
    );
  }
}

///onChangeプロパティもしくはcontrollerプロパティのいづれかを引数で渡す必要があります
class PageSetForm extends StatelessWidget {
  const PageSetForm({
    Key? key,
    this.onChange,
    this.controller,
    required this.title,
  }) : super(key: key);

  final void Function(String)? onChange;
  final TextEditingController? controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
