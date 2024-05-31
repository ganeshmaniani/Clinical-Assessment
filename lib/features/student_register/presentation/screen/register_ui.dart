import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class RegisterUI extends ConsumerStatefulWidget {
  const RegisterUI({super.key});

  @override
  ConsumerState<RegisterUI> createState() => _RegisterUIConsumerState();
}

class _RegisterUIConsumerState extends ConsumerState<RegisterUI>
    with InputValidationMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectGenderImage = "";

  String selectGender = '';
  final studentNameController = TextEditingController();
  final studentAgeController = TextEditingController();
  final schoolNameController = TextEditingController();
  bool isLoading = false;
  bool isGenderValid = true;
  @override
  void initState() {
    super.initState();
    // initCallUserInOut();
  }

  initCallUserInOut() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var userName = preferences.getString(DBKeys.dbStudentName);
    log(userName ?? "");
    if (userName != '') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  TabHomeScreen(selectedGenderImage: selectGenderImage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).errorColor;
    final errorStyle = Theme.of(context).inputDecorationTheme.errorStyle ??
        TextStyle(color: errorColor, fontSize: 16.sp);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 229, 229),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const RegisterAppBar(),
                SizedBox(height: 16.h),
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
                  validator: (studentAge) {
                    if (isCheckTextFieldIsEmpty(studentAge!)) {
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
                                          selectGenderImage = AppAssets.male;
                                        }
                                        Navigator.pop(context);
                                      })),
                              GenderSelectionItem(
                                  text: "Female",
                                  image: AppAssets.female,
                                  onSelect: (text) => setState(() {
                                        selectGender = text;
                                        selectGenderImage = AppAssets.female;
                                        Navigator.pop(context);
                                      })),
                              GenderSelectionItem(
                                  text: "Others",
                                  image: AppAssets.others,
                                  onSelect: (text) => setState(() {
                                        selectGender = text;
                                        selectGenderImage = AppAssets.others;
                                        Navigator.pop(context);
                                      }))
                            ])));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectGender,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.black,
                                      fontSize: 16.sp)),
                              Image.asset(selectGenderImage, width: 24.h)
                            ],
                          ),
                  ),
                ),
                if (!isGenderValid)
                  Padding(
                    padding: EdgeInsets.only(left: 36.w, top: 4.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter a gender",
                        style: errorStyle,
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
                    : RoundedButton(
                        title: 'Register',
                        type: RoundedButtonType.primary,
                        onPressed: () {
                          setState(() {
                            isGenderValid = selectGender.isNotEmpty;
                          });

                          if (formKey.currentState!.validate() &&
                              isGenderValid) {
                            setState(() => isLoading = true);
                            RegisterEntities registerEntities =
                                RegisterEntities(
                                    studentName: studentNameController.text,
                                    studentAge: studentAgeController.text,
                                    studentGender: selectGender,
                                    schoolName: schoolNameController.text);
                            ref
                                .read(registerProvider.notifier)
                                .register(registerEntities)
                                .then((response) => response.fold(
                                        (l) => log(l.message.toString()), (r) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TabHomeScreen(
                                                      selectedGenderImage:
                                                          selectGenderImage)),
                                          (route) => false);

                                      setState(() => isLoading = false);
                                    }));
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
}
