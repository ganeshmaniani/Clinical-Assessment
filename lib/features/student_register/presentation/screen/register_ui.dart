import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';
import 'package:skin_disease_backup/features/home/presentation/screen/home_ui.dart';
import 'package:skin_disease_backup/features/student_register/domain/entities/register_entities.dart';
import 'package:skin_disease_backup/features/student_register/presentation/provider/register_provider.dart';

import '../../../../config/config.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/core.dart';
import '../../../features.dart';
import 'widgets/widgets.dart';

class RegisterUI extends ConsumerStatefulWidget {
  const RegisterUI({super.key});

  @override
  ConsumerState<RegisterUI> createState() => _RegisterUIConsumerState();
}

class _RegisterUIConsumerState extends ConsumerState<RegisterUI> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String selectGenderImage = "";

  String selectGender = '';
  final studentNameController = TextEditingController();
  final studentAgeController = TextEditingController();
  final schoolNameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 229, 229),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisterAppBar(),
                SizedBox(height: 16.h),
                RoundedTextField(
                  hintText: "Student Name ",
                  controller: studentNameController,
                ),
                SizedBox(height: 8.h),
                RoundedTextField(
                  hintText: "Student Age",
                  controller: studentAgeController,
                  type: TextInputType.number,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ),
                SizedBox(height: 16.h),
                isLoading
                    ? const CircularProgressIndicator()
                    : RoundedButton(
                        title: 'Register',
                        type: RoundedButtonType.primary,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TabHomeScreen()));
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
