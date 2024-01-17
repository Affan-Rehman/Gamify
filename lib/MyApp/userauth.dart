// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'gamescreen.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius here
              ),
              backgroundColor: const Color(0xFF34495E),
              elevation: 0),
          onPressed: () async {
            try {
              User? user;
              user = await AuthService.signInWithApple(context: context);

              if (user != null) {
                await AuthService.adduserdetails(user, context);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GameScreen()));
              }
            } catch (e) {
              //
            }
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Icon(
                  Ionicons.logo_apple,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Sign In With Apple",
                style: TextStyle(color: Color(0xFFEA4335)),
              ),
            ],
          )),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius here
              ),
              backgroundColor:
                  const Color(0xFF34495E), // Set the background color here

              elevation: 0),
          onPressed: () async {
            try {
              User? user;
              user = await AuthService.signInWithGoogle(context: context);

              if (user != null) {
                await AuthService.adduserdetails(user, context);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GameScreen()));
              }
            } catch (e) {
              //
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/google_icon.png",
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.height * 0.03,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Sign In With Google",
                style: TextStyle(color: Color(0xFFEA4335)),
              ),
            ],
          )),
    );
  }
}

class AuthService {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    try {
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            showSnackBar(
                context,
                'The account already exists with a different credential.',
                1800);
          } else if (e.code == 'invalid-credential') {
            showSnackBar(context,
                'Error occurred while accessing credentials. Try again.', 1800);
          }
        } catch (e) {
          showSnackBar(
              context, 'Error occurred using Google Sign-In. Try again.', 1800);
        }
      }
    } catch (e) {
      log("exception in google dialog");
    }

    return user;
  }

  static void showSnackBar(BuildContext context, String s, int i) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
        duration: Duration(milliseconds: i),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<void> adduserdetails(User user, BuildContext context) async {
    try {
      // final fcmToken = await FirebaseMessaging.instance.getToken();
      if (await checkIfUserDocExists()) {
      } else {
        FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "userName": user.displayName,
          "phoneNumber": user.phoneNumber ?? "",
          "profileImgLink": user.photoURL ?? "",
          "uid": user.uid,
        });
      }
      showSnackBar(context, "Logged in", 1200);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString(), 1000);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<User?> signInWithApple({required BuildContext context}) async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your_client_id',
          redirectUri: Uri.parse('your_redirect_uri'),
        ),
      );

      final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
      final OAuthCredential credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await adduserdetails(user, context);
      }

      return user;
    } catch (error) {
      showSnackBar(
          context, 'Error occurred during Apple Sign-In. Try again.', 1800);
      return null;
    }
  }
}

Future<bool> checkIfUserDocExists() async {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  await auth.currentUser!.reload();
  final userDoc =
      await fireStore.collection("users").doc(auth.currentUser!.uid).get();
  return userDoc.exists;
}
