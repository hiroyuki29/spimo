import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
  return FirebaseAuthRepository();
});

class FirebaseAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

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
}
