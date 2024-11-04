import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool? isObscureText;
  final bool? readOnly;
  final Widget? suffixIcon;
  const AuthTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.isObscureText,
    this.readOnly,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            labelText,
            style: TextStyle(
              color: AppColors.instance.whiteColor,
              fontSize: 20.0,
            ),
          ),
        ),
        const Gap(16),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: AppColors.instance.lightBrown,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextFormField(
              controller: controller,
              obscureText: isObscureText ?? false,
              readOnly: readOnly ?? false,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: suffixIcon ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
