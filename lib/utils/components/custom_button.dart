import 'package:duseca_flutter_task/utils/appFonts/app_fonts.dart';
import 'package:duseca_flutter_task/utils/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  final RxBool isLoading;
  final String? assetImagePath;
  final Color? borderColor;
  final Color? fillColor;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPress,
    required this.isLoading,
    this.assetImagePath,
    this.borderColor = AppColors.primaryColor,
    this.fillColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: isLoading.value ? null : onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: fillColor,
            border: Border.all(
              color: borderColor!,
              width: 1.0,
            ),
          ),
          child: isLoading.value
              ? const Center(
            child: SpinKitFadingCircle(
              color: AppColors.blackColor,
              size: 35,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (assetImagePath != null) ...[
                Image.asset(
                  assetImagePath!,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                label,
                style: AppFonts.body(color: AppColors.blackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
