import 'package:duseca_flutter_task/utils/appFonts/app_fonts.dart';
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
 // Adjust the path as needed

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String heading;
  final String hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Color fillColor;
  final double? height;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.heading,
    this.label='',
    this.hintText = '',
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white38,
    this.height,
    // Default border color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
            child: Text(heading,style: AppFonts.body(color: AppColors.blackColor),)),
        SizedBox(height: height,),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            fillColor: fillColor,
            filled: true,  // Enables fill color

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.whiteColor, width: 2.0),  // Focused border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.whiteColor),  // Enabled border color
            ),
            suffixIcon: suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(
                suffixIcon,
                color: AppColors.blackColor.withOpacity(0.5),  // Icon color
              ),
            )
                : null,
          ),
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
