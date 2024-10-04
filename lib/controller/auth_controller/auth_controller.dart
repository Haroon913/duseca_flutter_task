import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_service.dart';
import '../../utils/errorUtils/error_utils.dart';
import '../../utils/routes/routes_name.dart';

class AuthController extends GetxController{

  RxBool isLoading=false.obs;
  RxBool isSigningUp=false.obs;
  RxBool isPasswordObscured = true.obs;

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final  emailController = TextEditingController().obs;
  final  passwordController = TextEditingController().obs;
  void togglePasswordVisibility() {
    isPasswordObscured.toggle();
  }
  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  Future<void> signup(BuildContext context) async {
    isLoading.value=true;
    String email = emailController.value.text;
    String password = passwordController.value.text;

    try {
      User? user = await _auth.signUp(email, password);
      if (user != null) {
        clearFields();
        Get.toNamed(
            RouteName.languageSelectionScreen,
        );
      }
    } catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(),context);
    } finally {
      isLoading.value=false;
    }

  }
  void login(BuildContext context) async {
    String email = emailController.value.text;
    String password = passwordController.value.text;
    isLoading.value = true;
    try {
      User? user = await _auth.logIn(email, password);
      if (user != null) {
        clearFields();
       Get.toNamed(RouteName.homeScreen);
      }
      else{
        ErrorUtils.flushBarErrorMessage('Login failed. Please check your credentials or internet connection.', context);
      }
      isLoading.value = true;
    }catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(), context);
    } finally {
      isLoading.value = false;
    }
  }
  void clearFields() {
    emailController.value.clear();
    passwordController.value.clear();
  }
  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

}



