import 'dart:developer';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class StudentDetailUI extends ConsumerStatefulWidget {
  final int studentId;
  const StudentDetailUI({required this.studentId, super.key});

  @override
  ConsumerState<StudentDetailUI> createState() =>
      _StudentDetailUIConsumerState();
}

class _StudentDetailUIConsumerState extends ConsumerState<StudentDetailUI> {
  StudentDetailModel studentDetailModel = StudentDetailModel();
  List<DiseaseDetailModel> diseaseDetailModel = [];
  bool isLoading = false;
  int totalScore = 0;
  @override
  void initState() {
    super.initState();
    initSingleStudentDetail();
    initialDiseaseDetail();
  }

  initSingleStudentDetail() async {
    setState(() => isLoading = true);
    log(widget.studentId.toString());
    ref
        .read(studentDetailProvider.notifier)
        .getSingleStudentDetail(widget.studentId)
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                isLoading = false;
              });
            }, (r) {
              setState(() {
                isLoading = false;
                studentDetailModel = r;
                isLoading = false;
              });
            }));
  }

  initialDiseaseDetail() {
    setState(() => isLoading = true);

    ref
        .read(diseaseDetailProvider.notifier)
        .getDiseaseDetail(widget.studentId)
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                isLoading = false;
              });
            }, (r) {
              setState(() {
                isLoading = false;
                diseaseDetailModel = r;
                isLoading = false;
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
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const HomeAppBar(title: "Report"),
          SizedBox(height: 16.h),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : StudentDetailContaner(
                  studentName: studentDetailModel.studentName ?? "",
                  studentAge: studentDetailModel.studentAge ?? '',
                  studentGender: studentDetailModel.studentGender ?? "",
                  schoolName: studentDetailModel.studentSchool ?? "",
                  isHome: false),
          SizedBox(height: 16.h),
          diseaseDetailModel.isEmpty || isLoading
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
                                    image: data.diseaseImage ?? Uint8List(0),
                                    bodyParts: data.diseaseName ?? "",
                                    score: data.diseaseScore.toString() ?? "",
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
            child: KButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Back"),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
