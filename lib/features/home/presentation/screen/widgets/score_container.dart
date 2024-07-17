
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreContainer extends StatelessWidget {
  final Widget child;
  const ScoreContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12.r),
        color: Colors.deepPurple.shade600,
        dashPattern: const [8, 4],
        padding: const EdgeInsets.all(4),
        child: Container(
          // width: MediaQuery.of(context).size.width / 2,
          height: 36.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100.withOpacity(.8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: child,
        ),
      ),
    );
  }
}
