import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? type;
  final bool? obscureText;
  final int maxLine;
  final Widget? right;
  final String? Function(String?)? validator;
  const RoundedTextField({
    super.key,
    required this.controller,
    this.type,
    this.obscureText,
    this.right,
    this.maxLine = 1,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLine,
        validator: validator,
        obscureText: obscureText ?? false,
        style: TextStyle(color: AppColor.black, fontSize: 16.sp),
        decoration: InputDecoration(
            fillColor: AppColor.white,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColor.grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
            suffixIcon: right),
      ),
    );
  }
}
