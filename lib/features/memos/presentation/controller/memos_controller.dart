
// final memosControllerProvider =
//     StateNotifierProvider.autoDispose<MemosController, AsyncValue<List<Memo>>>(
//         (ref) {
//   return MemosController(
//     memosUseCase: ref.watch(memosUseCaseProvider),
//     currentBook: ref.watch(currentBookControllerProvider),
//     userId: ref.watch(userControllerProvider)!.id,
//   );
// });

// class MemosController extends StateNotifier<AsyncValue<List<Memo>>> {
//   MemosController({
//     required this.memosUseCase,
//     required this.currentBook,
//     required this.userId,
//   }) : super(const AsyncData([]));

//   final MemosUseCase memosUseCase;
//   Book? currentBook;
//   String userId;

  
// }
