import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaptureImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CaptureImageButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: onPressed,
    child: Container(
      width: 50.w,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1, color: Colors.deepPurple.shade100),
      ),
      child: Icon(icon, color: Colors.deepPurple),
    ),
  );
  }
}
