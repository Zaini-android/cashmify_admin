import 'dart:developer';
import 'package:cashmify_admin/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snack/snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  validateInput() {
    var formState = formKey.currentState;
    if (formState!.validate()) {
      return true;
    } else {
      mode.value = AutovalidateMode.onUserInteraction;
      return false;
    }
  }

  RxBool loading = false.obs;
  Future login(BuildContext ctx) async {
    if (validateInput()) {
      loading.value = true;
      try {
        var credentials = await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        String adminUID = "4WMLT49wZHOpFW70KsuT1uhBQjI2";
        if (credentials.user!.uid == adminUID) {
          Get.offAll(() => Home());
        } else {
          _auth.signOut();
          var snack = const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Invalid User Account"),
            behavior: SnackBarBehavior.floating,
          );
          snack.show(ctx);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          var snack = const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Your password is wrong."),
            behavior: SnackBarBehavior.floating,
          );
          snack.show(ctx);
        } else if (e.code == 'user-not-found') {
          var snack = const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("User with this email doesn't exist."),
            behavior: SnackBarBehavior.floating,
          );
          snack.show(ctx);
        } else if (e.code == 'user-disabled') {
          var snack = const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("User with this email has been disabled."),
            behavior: SnackBarBehavior.floating,
          );
          snack.show(ctx);
        }
      } catch (e) {
        inspect(e);
      }
    }
    loading.value = false;
  }
}
