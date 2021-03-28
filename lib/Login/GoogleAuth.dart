// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleLogin {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<dynamic> loginGoogle() async {
//     try {
//       GoogleSignInAccount? account = await googleSignIn.signIn();
//       GoogleSignInAuthentication authentication = await account!.authentication;
//
//       AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: authentication.idToken, accessToken: authentication.accessToken);
//
//       final UserCredential result = await auth.signInWithCredential(credential);
//       print('접속함?');
//       return result.user;
//     } catch (error) {
//       print(error);
//     }
//   }
//
//   logout() async {
//     await auth.signOut();
//   }
// }