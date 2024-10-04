import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';  // Add file picker import
import 'dart:io';

import '../../controller/home_controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());  // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.sounds.isEmpty) {
                  return Center(child: Text('No sounds available'));
                }
                return ListView.builder(
                  itemCount: controller.sounds.length,
                  itemBuilder: (context, index) {
                    var sound = controller.sounds[index];
                    return ListTile(
                      title: Text(sound['title']),
                      subtitle: Text(sound['description']),
                      trailing: Obx(() => IconButton(
                        icon: controller.currentlyPlayingIndex.value == index
                            ? Icon(Icons.stop, color: Colors.red)
                            : Icon(Icons.play_arrow, color: Colors.green),
                        onPressed: () {
                          if (controller.currentlyPlayingIndex.value == index) {
                            controller.stopSound();
                          } else {
                            controller.playSound(sound['url'], index);  // Play specific sound
                          }
                        },
                      )),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async
              {
                // Pick an audio file from the device
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.audio,
                  allowMultiple: false,
                );

                if (result != null) {
                  File audioFile = File(result.files.single.path!);
                  String fileName = result.files.single.name;

                  // Upload the selected audio file to Firebase Storage
                  String audioUrl = await controller.uploadAudio(audioFile, fileName);
                  if (audioUrl.isNotEmpty) {
                    // Save metadata to Firestore
                    await controller.saveSoundToFirestore(
                        'Selected Sound', 'Sound uploaded from device', audioUrl, 60
                    );
                  }
                } else {
                  Get.snackbar('Error', 'No audio file selected');
                }
              },
              child: Text('Upload Sound'),
            )),
          ],
        ),
      ),
    );
  }
}
