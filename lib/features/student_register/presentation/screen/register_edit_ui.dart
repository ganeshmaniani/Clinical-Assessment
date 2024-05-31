import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class RegisterEditUI extends ConsumerStatefulWidget {
  final StudentDetailModel studentDetailModel;
  final String selectGenderImage;
  const RegisterEditUI(
      {required this.studentDetailModel,
      required this.selectGenderImage,
      super.key});

  @override
  ConsumerState<RegisterEditUI> createState() => _RegisterEditUIConsumerState();
}

class _RegisterEditUIConsumerState extends ConsumerState<RegisterEditUI>
    with InputValidationMixin {
  String selectGenderImage = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectGender = '';
  late TextEditingController studentNameController = TextEditingController();
  late TextEditingController studentAgeController = TextEditingController();
  late TextEditingController schoolNameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initiateReq();
  }

  initiateReq() {
    setState(() {
      studentNameController = TextEditingController(
          text: widget.studentDetailModel.studentName ?? '');
      studentAgeController = TextEditingController(
          text: widget.studentDetailModel.studentAge ?? '');
      schoolNameController = TextEditingController(
          text: widget.studentDetailModel.studentSchool ?? "");
      selectGender = widget.studentDetailModel.studentGender ?? '';
      selectGenderImage = widget.selectGenderImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAppBar(title: "Edit Registration"),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    RoundedTextField(
                      hintText: "Student Name ",
                      controller: studentNameController,
                      validator: (studentName) {
                        if (isCheckTextFieldIsEmpty(studentName!)) {
                          return null;
                        } else {
                          return 'Enter a student name';
                        }
                      },
                    ),
                    SizedBox(height: 8.h),
                    RoundedTextField(
                      hintText: "Student Age",
                      controller: studentAgeController,
                      type: TextInputType.number,
                      validator: (studentName) {
                        if (isCheckTextFieldIsEmpty(studentName!)) {
                          return null;
                        } else {
                          return 'Enter a student age';
                        }
                      },
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => Container(
                                color: Colors.grey.shade300,
                                height: 200.h,
                                child: ListView(children: [
                                  GenderSelectionItem(
                                      text: "Male",
                                      image: AppAssets.male,
                                      onSelect: (text) => setState(() {
                                            if (selectGender != "Male") {
                                              selectGender = text;
                                              selectGenderImage =
                                                  AppAssets.male;
                                            }
                                            Navigator.pop(context);
                                          })),
                                  GenderSelectionItem(
                                      text: "Female",
                                      image: AppAssets.female,
                                      onSelect: (text) => setState(() {
                                            selectGender = text;
                                            selectGenderImage =
                                                AppAssets.female;
                                            Navigator.pop(context);
                                          })),
                                  GenderSelectionItem(
                                      text: "Others",
                                      image: AppAssets.others,
                                      onSelect: (text) => setState(() {
                                            selectGender = text;
                                            selectGenderImage =
                                                AppAssets.others;
                                            Navigator.pop(context);
                                          }))
                                ])));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: selectGender == ""
                            ? Text(
                                'Student Gender',
                                style: TextStyle(
                                    color: AppColor.grey, fontSize: 16.sp),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(selectGender,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black,
                                          fontSize: 16.sp)),
                                  Image.asset(
                                    selectGenderImage,
                                    height: 24.h,
                                  )
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RoundedTextField(
                      hintText: "School Name",
                      controller: schoolNameController,
                      validator: (schoolName) {
                        if (isCheckTextFieldIsEmpty(schoolName!)) {
                          return null;
                        } else {
                          return 'Enter a school name';
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Row(
                            children: [
                              Expanded(
                                  child: RoundedButton(
                                      title: "Back",
                                      type: RoundedButtonType.secondary,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })),
                              Expanded(
                                child: RoundedButton(
                                    title: 'Register',
                                    type: RoundedButtonType.primary,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        setState(() => isLoading = true);
                                        final SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var id = preferences
                                            .getInt(DBKeys.dbColumnId);
                                        RegisterEditEntities
                                            registerEditEntities =
                                            RegisterEditEntities(
                                          id: id.toString(),
                                          studentName:
                                              studentNameController.text,
                                          studentAge: studentAgeController.text,
                                          studentGender: selectGender,
                                          schoolName: schoolNameController.text,
                                        );
                                        ref
                                            .read(registerProvider.notifier)
                                            .registerEdit(registerEditEntities)
                                            .then((response) => response.fold(
                                                    (l) => log(
                                                        l.message.toString()),
                                                    (r) {
                                                  Navigator.pop(context);
                                                  setState(
                                                      () => isLoading = false);
                                                }));
                                      }
                                    }),
                              ),
                            ],
                          )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
