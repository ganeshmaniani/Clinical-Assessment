import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/app_assets.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';

class RegisterAppBar extends StatelessWidget {
  const RegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 16, right: 20, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.2,
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
        children: [
          // Image.asset(AppAssets.appIcon, height: 150.h),
          Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: const AssetImage(AppAssets.appIcon),
                    fit: BoxFit.cover,
                    scale: 100.sp)),
          ),
          SizedBox(height: 16.h),
          Text(
            "General Information",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
