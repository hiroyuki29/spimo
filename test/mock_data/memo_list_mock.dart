import 'package:spimo/features/memos/domain/model/memo.dart';
import 'package:spimo/features/memos/domain/model/memo_text.dart';

List<Memo> mockMemoList = <Memo>[
  Memo(
    id: 'id1',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 3,
    endPage: 3,
    createdAt: DateTime(1000),
    isTitle: false,
  ),
  Memo(
    id: 'id2',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 1,
    endPage: 1,
    createdAt: DateTime(2000),
    isTitle: false,
  ),
  Memo(
    id: 'id3',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 2,
    endPage: 3,
    createdAt: DateTime(3000),
    isTitle: false,
  ),
];

List<Memo> sortedMemoListForTest = <Memo>[
  Memo(
    id: 'id2',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 1,
    endPage: 3,
    createdAt: DateTime(2000),
    isTitle: false,
  ),
  Memo(
    id: 'id3',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 2,
    endPage: 3,
    createdAt: DateTime(3000),
    isTitle: false,
  ),
  Memo(
    id: 'id1',
    contents: [
      MemoText(
        text: 'text',
        textColor: TextColor.black,
      )
    ],
    bookId: 'bookId',
    startPage: 3,
    endPage: 3,
    createdAt: DateTime(1000),
    isTitle: false,
  ),
];
