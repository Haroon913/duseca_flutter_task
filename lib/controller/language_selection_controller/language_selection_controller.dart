import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duseca_flutter_task/utils/errorUtils/error_utils.dart';
import 'package:duseca_flutter_task/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LanguageSelectionController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var languages = [
    RxMap({'name': 'English', 'flag': '🇬🇧', 'selected': true}),
    RxMap({'name': 'French', 'flag': '🇫🇷', 'selected': false}),
    RxMap({'name': 'Spanish', 'flag': '🇪🇸', 'selected': false}),
  ].obs;

  var searchQuery = ''.obs;
  var isLoading = false.obs;
  var selectedLanguage = 'English'.obs;

  void selectLanguage(int index) {
    for (var i = 0; i < languages.length; i++) {
      languages[i]['selected'] = i == index;
    }
    selectedLanguage.value = languages[index]['name'] as String;
  }


  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void continueAction() async {
    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'selectedLanguage': selectedLanguage.value,
        }, SetOptions(merge: true));
      }
      isLoading.value = false;
      Get.toNamed(RouteName.homeScreen);
      ErrorUtils.showSnackbar(title:'Success', message: 'Selected language: ${selectedLanguage.value}');
    } catch (e) {
      isLoading.value = false;
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);

    }
  }
}
