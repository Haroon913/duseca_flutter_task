import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duseca_flutter_task/utils/errorUtils/error_utils.dart';
import 'package:duseca_flutter_task/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controller/home_controller/home_controller.dart';


class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      registerUser(user!);
      return user;
    } catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
    }
    return null;
  }


  Future<User?> logIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  Future<void> registerUser(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'uid': user.uid,
      });
      ErrorUtils.showSnackbar(title: 'Success', message: 'Registered Successfully');
    } catch (e) {
     ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.delete<HomeController>();
    Get.toNamed(RouteName.loginScreen);
  }

}
