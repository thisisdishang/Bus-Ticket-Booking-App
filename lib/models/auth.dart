import 'package:bus_ticket_booking_app/pages/homepage.dart';
import 'package:bus_ticket_booking_app/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// creating firebase instance
/*
final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signup(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user  = result.user;

    if( result != null){
      Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()),);
    }
    // if (result != null) {
    // Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => HomePage()));
  }  // if result not null we simply call the MaterialpageRoute,
  // for go to the HomePage screen
}
//}
*/

class AuthController extends GetxController {
  signUp(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .add({"name": name, "email": email, "password": password});
        // print("Done");
        Get.snackbar("Sign Up", "Sign Up successfully",
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(LoginPage());
      });
      update();
    } catch (e) {
      print(e);
      Get.snackbar("Something went wrong", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  LoginIn(BuildContext context, String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar("Login", "Login successfully",
            snackPosition: SnackPosition.BOTTOM);
        preferences.setString('token',
            FirebaseAuth.instance.currentUser!.getIdToken().toString());
        preferences.setString('email', email);
        preferences.setString(
            'userId', FirebaseAuth.instance.currentUser!.uid.toString());
        preferences.setString('displayname',
            FirebaseAuth.instance.currentUser!.displayName.toString());
        preferences.setString(
            'photo', FirebaseAuth.instance.currentUser!.photoURL.toString());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
        update();
      });
      update();
    } catch (e) {
      print(e);
      Get.snackbar("Something went wrong", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        Get.snackbar("Reset Password", "Send request successfully",
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(const LoginPage());
        update();
      });
      update();
    } catch (e) {
      print(e);
      Get.snackbar("Something went wrong", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // changePassword(String newPassword) async {
  //   try{
  //    await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  //    Get.snackbar("Change Password", "Password successfully changed",snackPosition: SnackPosition.BOTTOM);
  //    Get.offAll(const HomeScreen());
  //   }catch(e){
  //     print(e);
  //   }
  // }

  changePassword(String currentPassword, String newPassword) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user!.email.toString(), password: currentPassword);
      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          Get.snackbar("Change Password", "Password successfully changed",
              snackPosition: SnackPosition.BOTTOM);
          // Get.offAll(const HomePage());
        }).catchError((error) {
          Get.snackbar("Something went wrong", error.toString(),
              snackPosition: SnackPosition.BOTTOM);
        });
      }).catchError((err) {
        Get.snackbar("Something went wrong", err.toString(),
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('userId') == "";
        preferences.clear();
        Get.offAll(const LoginPage());
      });
    } catch (e) {
      Get.snackbar("Something went wrong", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
