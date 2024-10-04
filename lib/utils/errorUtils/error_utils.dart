
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';

class ErrorUtils{
  static void flushBarErrorMessage(String message,BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(message: message,
        backgroundColor: Colors.red,
        title: 'Error',messageColor: AppColors.whiteColor,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        reverseAnimationCurve: Curves.easeInOut,
        icon:  Icon(Icons.error,size: 25,color: AppColors.whiteColor,),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(15),
        duration: const Duration(seconds: 3),)..show(context),
    );
  }
  static void showSnackbar({
    required String title,
    required String message,
    Color backgroundColor = AppColors.whiteColor,
    Color textColor = AppColors.blackColor,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
    IconData icon = Icons.check_circle_outline,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,

      duration: duration,
      icon: Icon(
        icon,
        color: textColor,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 500),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      snackStyle: SnackStyle.FLOATING,
    );
  }



}