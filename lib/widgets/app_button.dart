import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String btnTxt;
  final Function() onTap;
  const AppButton({
    super.key,
    required this.btnTxt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.instance.whiteColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          btnTxt,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
