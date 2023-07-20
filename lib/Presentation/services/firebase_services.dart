// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        return await auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}

// class FirebaseServices {
//   final auth = FirebaseAuth.instance;
//   final googleSignIn = GoogleSignIn();

//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;
//         final AuthCredential authCredential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//         await auth.signInWithCredential(authCredential);
//       }
//     } on FirebaseAuthException catch (e) {
//       print('Firebase Auth Error: ${e.message}');
//       throw e;
//     } catch (e) {
//       print('Unexpected Error: $e');
//       throw e;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await auth.signOut();
//       await googleSignIn.signOut();
//     } catch (e) {
//       print('Sign Out Error: $e');
//       throw e;
//     }
//   }
// }
