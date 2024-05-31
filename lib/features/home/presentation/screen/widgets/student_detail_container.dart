import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';

class StudentDetailContaner extends StatelessWidget {
  final String studentName;
  final String studentAge;
  final String studentGender;
  final String schoolName;
  final bool isHome;
  final VoidCallback? editFunction;
  final VoidCallback? deleteFunction;

  const StudentDetailContaner(
      {super.key,
      required this.studentName,
      required this.studentAge,
      required this.studentGender,
      required this.schoolName,
      this.editFunction,
      this.deleteFunction,
      required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16).w,
      padding: const EdgeInsets.only(top: 16).w,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isHome ? SizedBox(width: 90.w) : const SizedBox(),
            Column(
              children: [
                Text(studentName,
                    style: TextStyle(color: AppColor.black, fontSize: 16.sp)),
                Text(studentAge,
                    style: TextStyle(color: AppColor.black, fontSize: 16.sp))
              ],
            ),
            isHome
                ? IconButton(
                    onPressed: editFunction, icon: const Icon(Icons.edit))
                : const SizedBox(),
            isHome
                ? IconButton(
                    onPressed: deleteFunction,
                    icon: const Icon(Icons.delete, color: Colors.red))
                : const SizedBox(),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.grey.withOpacity(0.4)),
                  right: BorderSide(color: AppColor.grey.withOpacity(0.4)),
                ),
              ),
              child: Text(studentGender,
                  style: TextStyle(color: AppColor.black, fontSize: 16.sp)),
            )),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.grey.withOpacity(0.4)),
                  left: BorderSide(color: AppColor.grey.withOpacity(0.4)),
                ),
              ),
              child: Text(
                schoolName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.sp),
              ),
            ))
          ],
        )
      ]),
    );
  }
}
