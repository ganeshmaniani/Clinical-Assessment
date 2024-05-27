import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 5.h,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: AppColor.primary
          // gradient: LinearGradient(
          //     colors: [Color(0xff886ff2), Color(0xff6849ef)],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight)
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(AppAssets.logo, height: 250.h),

          studentDetailText(
              student: "Clinical assessment of Malnutrition",
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
