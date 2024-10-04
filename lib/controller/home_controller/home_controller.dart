import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duseca_flutter_task/utils/errorUtils/error_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> sounds = <Map<String, dynamic>>[].obs;
  RxInt currentlyPlayingIndex = (-1).obs;

  RxString userEmail = ''.obs;
  RxString userLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSounds();
    fetchUserData();
  }

  void fetchSounds() {
    _firestore.collection('sounds').snapshots().listen((QuerySnapshot snapshot) {
      sounds.clear();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        sounds.add(doc.data() as Map<String, dynamic>);
      }
    });
  }

  Future<void> fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        userEmail.value = doc['email'] ?? user.email!;
        userLanguage.value = doc['selectedLanguage'] ?? 'English';
      }
    } catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
    }
  }

  Future<void> pickAndUploadAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      File audioFile = File(result.files.single.path!);
      String fileName = result.files.single.name;
      String audioUrl = await uploadAudio(audioFile, fileName);
      if (audioUrl.isNotEmpty) {
        await saveSoundToFirestore(
          'Selected Sound',
          'Sound uploaded from device',
          audioUrl,
          60,
        );
        ErrorUtils.showSnackbar(title: 'Success', message: 'Audio uploaded successfully!');

      }
    } else {
      ErrorUtils.flushBarErrorMessage('No audio file selected', Get.context!);
    }
  }


  Future<String> uploadAudio(File audioFile, String fileName) async {
    try {
      isLoading.value = true;
      Reference ref = FirebaseStorage.instance.ref().child('sounds/$fileName');
      UploadTask uploadTask = ref.putFile(audioFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      isLoading.value = false;
      return downloadURL;
    } catch (e) {
      isLoading.value = false;
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
      return '';
    }
  }

  Future<void> saveSoundToFirestore(String title, String description, String audioUrl, int duration) async {
    try {
      await _firestore.collection('sounds').add({
        'title': title,
        'description': description,
        'url': audioUrl,
        'duration': duration,
      });
    } catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
    }
  }

  Future<void> playSound(String url, int index) async {
    try {
      if (currentlyPlayingIndex.value == index) {
        stopSound();
        return;
      }
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      currentlyPlayingIndex.value = index;
    } catch (e) {
      ErrorUtils.flushBarErrorMessage(e.toString(), Get.context!);
    }
  }

  void stopSound() {
    _audioPlayer.stop();
    currentlyPlayingIndex.value = -1;
  }
}
