import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isIcon;
  final Color color;

  const KButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isIcon = false,
    this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        // margin: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon
                ? const Icon(Icons.camera_alt_rounded, color: Colors.white)
                : const SizedBox(),
            SizedBox(width: 8.w),
            Text(text,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
