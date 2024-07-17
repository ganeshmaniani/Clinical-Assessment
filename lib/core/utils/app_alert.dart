import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';

class AppAlert {
  const AppAlert._();
  static displaySnackBar(BuildContext context, {required String message, required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            isSuccess
                ? const Icon(Icons.check_circle, color: Colors.white, size: 30)
                : const Icon(Icons.error, color: Colors.white, size: 30),
            Expanded(
              child: Text(message,
                  style: TextStyle(color: AppColor.white, fontSize: 12.sp)),
            ),
          ],
        ),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }
}
