import 'package:duseca_flutter_task/utils/appFonts/app_fonts.dart';
import 'package:duseca_flutter_task/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left line
        const Expanded(
          child: Divider(
            color: AppColors.whiteColor,
            thickness: 1.0,
            indent: 20.0,
            endIndent: 10.0,
          ),
        ),
        // 'or' text in the middle
        Text(
          'or',
          style: AppFonts.body(color: AppColors.whiteColor)
        ),
        // Right line
        const Expanded(
          child: Divider(
            color: AppColors.whiteColor, // Line color
            thickness: 1.0,
            indent: 10.0,
            endIndent: 20.0,
          ),
        ),
      ],
    );
  }
}
