import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/domain/model/app_user.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';
import 'package:spimo/features/books/domain/repository/book_storage_repository.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, AppUser?>((ref) {
  return UserController(
    userRepository: ref.watch(userRepositoryProvider),
    bookStorageRepository: ref.watch(bookStorageProvider),
  );
});

class UserController extends StateNotifier<AppUser?> {
  UserController({
    required this.userRepository,
    required this.bookStorageRepository,
  }) : super(null);

  final UserRepository userRepository;
  final BookStorageRepository bookStorageRepository;

  Future<void> fetchUser(String userId) async {
    try {
      state = await userRepository.fetchUser(userId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setCurrentBookId(String bookId) async {
    if (state == null) {
      return;
    }
    state = state!.copyWith(currentBookId: bookId);
  }

  Future<void> resetCurrentBookId() async {
    if (state == null) {
      return;
    }
    state = state!.copyWith(currentBookId: '');
  }

  Future<void> editUser({
    required String emailAddress,
    required String password,
    required String nickName,
  }) async {
    if (state == null) {
      return;
    }
    await userRepository.editUser(
      emailAddress: emailAddress,
      password: password,
      nickName: nickName,
    );
    await fetchUser(state!.id);
  }
}
