import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';

class CardContainer extends StatelessWidget {
  final Widget topChild;
  final Widget bottomChild;
  final bool isTrue;

  const CardContainer(
      {super.key,
      required this.topChild,
      required this.bottomChild,
      required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.deepPurple.shade100,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0).w,
            width: MediaQuery.of(context).size.width.w,
            decoration: BoxDecoration(
              color: isTrue ? AppColor.primary : Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: topChild,
          ),
          Container(
            padding: const EdgeInsets.all(8.0).w,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: isTrue ? Colors.transparent : AppColor.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: bottomChild,
          ),
        ],
      ),
    );
  }
}

class StoreScore extends StatelessWidget {
  final String bodyParts;
  final String score;
  final Uint8List image;

  const StoreScore(
      {super.key,
      required this.bodyParts,
      required this.score,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: MemoryImage(image),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 8.w),
          Text(bodyParts, style: TextStyle(fontSize: 16.sp)),
          const Spacer(),
          Text(score, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
