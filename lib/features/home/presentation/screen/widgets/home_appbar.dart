import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final bool isHome;
  const HomeAppBar({super.key, required this.title, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80.h, left: 16, right: 16, bottom: 16).w,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: AppColor.primary),
      child: isHome
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                studentDetailText(
                    student: title,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800),
                // const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StudentListUI()));
                    },
                    icon: Icon(Icons.history_sharp, color: AppColor.white)),
              ],
            )
          : Column(
              children: [
                // Image.asset(AppAssets.logo, height: 250.h),

                studentDetailText(
                    student: title,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800),
              ],
            ),
    );
  }

  Widget studentDetailText(
      {required String student,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.w600}) {
    return Text(
      student,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColor.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
