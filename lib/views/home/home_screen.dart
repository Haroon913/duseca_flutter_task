import 'package:duseca_flutter_task/services/auth_service.dart';
import 'package:duseca_flutter_task/utils/appFonts/app_fonts.dart';
import 'package:duseca_flutter_task/utils/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../utils/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  final FirebaseAuthServices _authServices =FirebaseAuthServices();

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*.99;
    final width=MediaQuery.of(context).size.width*.99;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen',style: AppFonts.heading(color: AppColors.blackColor),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            _authServices.logout();
          }, icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: height*.03),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text('User Details',style: AppFonts.heading(color: AppColors.blackColor),),
                  SizedBox(height: height*.02),
                  Obx(() => Text(
                    'User Email: ${controller.userEmail.value}',
                    style: AppFonts.body(color: AppColors.blackColor),
                  )),
                  SizedBox(height: height*.01),
                  Obx(() => Text(
                    'Selected Language: ${controller.userLanguage.value}',
                    style: AppFonts.body(color: AppColors.blackColor),
                  )),
                ],
              ),
            ),

            SizedBox(height: height*.05),

            Expanded(
              child: Obx(() {
                if (controller.sounds.isEmpty) {
                  return Center(child: Text('No sounds available',style: AppFonts.heading(color: AppColors.blackColor),),);
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
                            controller.playSound(sound['url'], index);
                          }
                        },
                      )),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: height*.03),
            CustomButton(label: 'Upload Audio',
                onPress: (){
                  controller.pickAndUploadAudio();
                }, isLoading: controller.isLoading)
          ],
        ),
      ),
    );
  }
}
