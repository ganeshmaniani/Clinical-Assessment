
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final int currentIndex;
  final int index;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        padding: const EdgeInsets.all(4),
        width: 70.w,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentIndex == index ? AppColor.primary : Colors.white70,
            borderRadius: currentIndex == index
                ? BorderRadius.circular(14.r)
                : BorderRadius.circular(10.r),
            border: currentIndex == index
                ? Border.all(color: Colors.deepPurple, width: 2)
                : Border.all(color: Colors.grey, width: 2)),
        child: Text(text,
            style: TextStyle(
                fontSize: 16.sp,
                color: currentIndex == index ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
