import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final int id;
  const ResultScreen({required this.id, super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenConsumerState();
}

class _ResultScreenConsumerState extends ConsumerState<ResultScreen> {
  StudentDetailModel studentDetailModel = StudentDetailModel();
  List<DiseaseDetailModel> diseaseDetailModel = [];
  bool isLoading = false;
  bool isStudentDetailLoading = false;
  int totalScore = 0;

  @override
  void initState() {
    initialStudentDetail();
    initialDiseaseDetail();
    super.initState();
  }

  initialStudentDetail() {
    setState(() => isLoading = true);

    ref
        .read(homeProvider.notifier)
        .getStudentDetail()
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                isStudentDetailLoading = false;
              });
            }, (r) {
              setState(() {
                isStudentDetailLoading = false;
                studentDetailModel = r;
                isStudentDetailLoading = false;
              });
            }));
  }

  initialDiseaseDetail() {
    setState(() => isLoading = true);

    ref
        .read(diseaseDetailProvider.notifier)
        .getDiseaseDetail(widget.id)
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                isStudentDetailLoading = false;
              });
            }, (r) {
              setState(() {
                isStudentDetailLoading = false;
                diseaseDetailModel = r;
                isStudentDetailLoading = false;
                totalScore = calculateTotalScore();
              });
            }));
  }

  int calculateTotalScore() {
    for (var disese in diseaseDetailModel) {
      totalScore += disese.diseaseScore ?? 0;
    }
    return totalScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.white, body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const HomeAppBar(title: "Report"),
          SizedBox(height: 16.h),
          StudentDetailContaner(
              studentName: studentDetailModel.studentName ?? "",
              studentAge: studentDetailModel.studentAge ?? '',
              studentGender: studentDetailModel.studentGender ?? "",
              schoolName: studentDetailModel.studentSchool ?? "",
              isHome: false),
          SizedBox(height: 16.h),
          diseaseDetailModel.isEmpty
              ? const SizedBox()
              : CardContainer(
                  topChild: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clinical Assessment Score',
                          style: TextStyle(
                              fontSize: 18.sp, color: AppColor.primary),
                        ),
                        SizedBox(height: 10.h),
                        Column(
                          children: diseaseDetailModel
                              .map((data) => StoreScore(
                                    bodyParts: data.diseaseName ?? "",
                                    score: data.diseaseScore.toString(),
                                    image: data.diseaseImage ?? Uint8List(0),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  bottomChild: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style:
                              TextStyle(color: AppColor.white, fontSize: 18.sp),
                        ),
                        Text(
                          totalScore.toString(),
                          style:
                              TextStyle(color: AppColor.white, fontSize: 18.sp),
                        ),
                      ],
                    ),
                  ),
                  isTrue: false),
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).w,
            child: Row(
              children: [
                Expanded(
                    child: KButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        text: "Back")),
                SizedBox(width: 8.w),
                Expanded(
                  child: KButton(
                      onTap: () async {
                        showAlertBox(context,
                            title: "Add Student",
                            description: "Are you add new student",
                            dialogType: DialogType.question,
                            animType: AnimType.bottomSlide,
                            btnCancelText: "No",
                            btnOkText: "Yes", btnOkOnPress: () async {
                          final SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.remove(DBKeys.dbColumnId);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterUI()),
                              (route) => false);
                        }, btnCancelOnPress: () {});
                      },
                      text: "Add Student"),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
