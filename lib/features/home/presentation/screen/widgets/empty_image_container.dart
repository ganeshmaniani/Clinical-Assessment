import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyImageContainer extends StatelessWidget {
  final String diseaseName;
  const EmptyImageContainer({super.key, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      color: Colors.deepPurple.shade600,
      dashPattern: const [8, 4],
      padding: const EdgeInsets.all(4),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100.withOpacity(.8),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              size: 60,
              color: Colors.deepPurple.shade400,
            ),
            SizedBox(height: 12.h),
            Text(
              'Please capture or select the\n$diseaseName image ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
