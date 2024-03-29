import 'package:spimo/features/memos/domain/repository/memo_storage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:spimo/features/memos/use_case/memos_use_case.dart';

import 'memo_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MemoStorageRepository>()])
void main() {
  var memoStorageRepository = MockMemoStorageRepository();
  var memosUseCase = MemosUseCase(memoStorageRepository: memoStorageRepository);

  // test('firstTest', () async {
  //   when(memoStorageRepository.fetchBookMemos(
  //           userId: 'userId', bookId: 'bookId'))
  //       .thenAnswer((_) async => mockMemoList);
  //   expect(
  //     await memosUseCase.fetchBookMemos(userId: 'userId', bookId: 'bookId'),
  //     sortedMemoListForTest,
  //   );
  // });
}
