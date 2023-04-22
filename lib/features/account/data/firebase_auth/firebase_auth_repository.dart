import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spimo/features/account/domain/model/app_user.dart';
import 'package:spimo/features/account/domain/respository/user_repository.dart';

class FirebaseAuthRepository implements UserRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<String?> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String nickName,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final userId = credential.user!.uid;
      await db.collection('users').doc(userId).set({
        'id': userId,
        'email': emailAddress,
        'nickName': nickName,
        'currentBookId': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('パスワードは6文字以上で設定してください');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('このメールアドレスは既に登録されています');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<String?> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('このメールアドレスは登録されていません');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('パスワードが間違っています');
      }
    }
    return null;
  }

  @override
  Future<AppUser> fetchUser(String userId) {
    final user = db.collection('users').doc(userId).get().then((doc) {
      final data = doc.data();
      return AppUser.fromJson(data!);
    });
    return user;
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> deleteUser() async {
    try {
      final data = {
        "userId": auth.currentUser!.uid,
        "deletedAt": FieldValue.serverTimestamp(),
      };
      await db.collection('deletedUsers').add(data);
      await signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> resetPassword({required String emailAddress}) async {
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException {
      throw ('エラーが発生しました');
    }
    return;
  }
}
