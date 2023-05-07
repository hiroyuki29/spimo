import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
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
        throw ('パスワードが間違っています');
        print('パスワードが間違っています');
      }
    }
    return null;
  }

  @override
  Future<String?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
// Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await auth.signInWithCredential(credential);
      final userId = userCredential.user!.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': userCredential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }

  @override
  Future<String?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // OAthCredentialのインスタンスを作成
      OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await auth.signInWithCredential(credential);
      final userId = userCredential.user!.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': userCredential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }

  @override
  Future<String?> signInAnonymously() async {
    try {
      final userCredential = await auth.signInAnonymously();
      final userId = userCredential.user!.uid;
      await db.collection('users').doc(userId).set({
        'id': userId,
        'email': '',
        'nickName': '',
        'currentBookId': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }

  @override
  bool isAnonymous() {
    final currentUser = auth.currentUser;
    return currentUser != null && currentUser.isAnonymous;
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

  @override
  Future<void> editUser({
    required String emailAddress,
    required String password,
    required String nickName,
  }) async {
    try {
      final currentUser = auth.currentUser!;
      await currentUser.updateEmail(emailAddress);
      final userId = currentUser.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': emailAddress,
        'nickName': nickName,
      });

      if (password != '') {
        await currentUser.updatePassword(password);
      }
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
    return;
  }

  @override
  Future<String?> linkWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String nickName,
  }) async {
    try {
      final credential =
          EmailAuthProvider.credential(email: emailAddress, password: password);
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      final userId = userCredential!.user!.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': emailAddress,
        'nickName': nickName,
        'currentBookId': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }

  @override
  Future<String?> linkWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // OAthCredentialのインスタンスを作成
      OAuthProvider oauthProvider = OAuthProvider('apple.com');
      final credential = oauthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      final userId = userCredential!.user!.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': userCredential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }

  @override
  Future<String?> linkWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      final userId = userCredential!.user!.uid;
      await db.collection('users').doc(userId).update({
        'id': userId,
        'email': userCredential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return userId;
    } catch (e) {
      throw ('エラーが発生しました');
    }
  }
}
