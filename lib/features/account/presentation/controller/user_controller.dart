import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spimo/features/account/domain/model/app_user.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, AppUser?>((ref) {
  return UserController(userRepository: ref.watch(userRepositoryProvider));
});

class UserController extends StateNotifier<AppUser?> {
  UserController({required this.userRepository}) : super(null);

  final UserRepository userRepository;

  Future<void> fetchUser(String userId) async {
    state = await userRepository.fetchUser(userId);
  }
}
