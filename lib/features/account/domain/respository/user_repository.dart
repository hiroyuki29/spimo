import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spimo/features/account/data/firebase_auth/firebase_auth_repository.dart';
import 'package:spimo/features/account/domain/model/app_user.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>((ref) {
  return FirebaseAuthRepository();
});

abstract class UserRepository {
  Future<String?> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String nickName,
  });

  Future<String?> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<String?> signInWithGoogle();

  Future<String?> signInWithApple();

  Future<String?> signInAnonymously();

  bool isAnonymous();

  Future<String?> linkWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String nickName,
  });

  Future<String?> linkWithGoogle();

  Future<String?> linkWithApple();

  Future<AppUser> fetchUser(String userId);

  Future<void> signOut();

  Future<void> editUser({
    required String emailAddress,
    required String password,
    required String nickName,
  });

  Future<void> deleteUser();

  Future<void> resetPassword({required String emailAddress});
}
