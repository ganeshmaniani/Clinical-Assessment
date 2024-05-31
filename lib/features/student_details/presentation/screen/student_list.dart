import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class StudentListUI extends ConsumerStatefulWidget {
  const StudentListUI({super.key});

  @override
  ConsumerState<StudentListUI> createState() => _StudentListUIConsumerState();
}

class _StudentListUIConsumerState extends ConsumerState<StudentListUI> {
  bool isLoading = false;
  List<StudentDetailModel> studentList = [];
  @override
  void initState() {
    super.initState();
    initialStudentList();
  }

  initialStudentList() async {
    setState(() => isLoading = true);
    ref
        .read(studentDetailProvider.notifier)
        .getStudentList()
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                isLoading = false;
              });
            }, (r) {
              setState(() {
                studentList = r;
                isLoading = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const HomeAppBar(title: "List Of Student"),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: studentList.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => StudentDetailUI(
                                    studentId: studentList[index].id ?? 0)));
                      },
                      child: StudentListCard(
                        name: studentList[index].studentName ?? '',
                        school: studentList[index].studentSchool ?? "",
                        onDelete: () async {
                          showAlertBox(context,
                              title: "Delete Student Detail",
                              description: "Are you sure?",
                              btnCancelText: "No",
                              btnOkText: "Yes",
                              dialogType: DialogType.warning,
                              animType: AnimType.bottomSlide,
                              btnOkOnPress: () async {
                            ref
                                .read(homeProvider.notifier)
                                .deleteStudent(studentList[index].id ?? 0)
                                .then((response) =>
                                    response.fold((l) => log(l.message), (r) {
                                      initialStudentList();
                                    }));
                          }, btnCancelOnPress: () {});
                        },
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => SizedBox(height: 8.h),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: KButton(onTap: () => Navigator.pop(context), text: "Back"),
        ),
        SizedBox(height: 16.h)
      ],
    );
  }
}
