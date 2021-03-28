import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential? userCredential;
  User? user;

  Future<String?> signUp(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await sendEmailVerification();
      user = userCredential?.user;
      return '회원가입 완료';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('짧은 비밀번호');
      } else if (e.code == 'email-already-in-use') {
        print('이미 존재하는 이메일');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      print('로그인');
      userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> sendEmailVerification() async {
    print('이메일 인증');
    User user = FirebaseAuth.instance.currentUser!;
    if (user.emailVerified == false) {
      await user.sendEmailVerification();
      print('이메일 인증 false');
      return false;
    }
    print('이메일 인증 true');
    return true;
  }

  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}
