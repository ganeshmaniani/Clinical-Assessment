import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_disease_backup/core/constants/color_extension.dart';
import 'package:skin_disease_backup/features/home/data/model/student_detail_model.dart';
import 'package:skin_disease_backup/features/home/presentation/screen/widgets/home_appbar.dart';
import 'package:skin_disease_backup/features/student_register/presentation/screen/widgets/register_appbar.dart';
import '../../../../core/utils/image_picker_utils.dart';
import '../../../../core/widgets/button.dart';
import '../provider/home_provider.dart';
import 'widgets/image_container.dart';

class TabHomeScreen extends ConsumerStatefulWidget {
  const TabHomeScreen({super.key});

  @override
  ConsumerState<TabHomeScreen> createState() => _TabHomeScreenConsumerState();
}

class _TabHomeScreenConsumerState extends ConsumerState<TabHomeScreen> {
  final List diseases = [
    "Eye",
    "Mouth",
    "Tongue",
    "Gums",
    "Teeth",
    "Hair",
    "Skin",
    "Elbow",
    "Nail"
  ];
  final ImagePickerUtils imagePickerUtils = ImagePickerUtils();

  Map<String, Map<String, dynamic>> diseaseImages = {
    "Eye": {},
    "Mouth": {},
    "Tongue": {},
    "Gums": {},
    "Teeth": {},
    "Hair": {},
    "Skin": {},
    "Elbow": {},
    "Nail": {},
  };
  int currentIndex = 0;
  // int? score;
  bool isLoading = false;
  bool isStudentDetailLoading = false;
  StudentDetailModel studentDetailModel = StudentDetailModel();
  @override
  void initState() {
    initialStudentDetail();

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const HomeAppBar(),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text("General Information",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: AppColor.black, fontSize: 18.sp)),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: TextStyle(
                              color: AppColor.black, fontSize: 16.sp)),
                      Text("Age",
                          style: TextStyle(
                              color: AppColor.black, fontSize: 16.sp)),
                      Text("Gender",
                          style: TextStyle(
                              color: AppColor.black, fontSize: 16.sp)),
                      Text("School Name",
                          style: TextStyle(
                              color: AppColor.black, fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(studentDetailModel.studentName ?? "",
                            style: TextStyle(
                                color: AppColor.black, fontSize: 16.sp)),
                        Text(studentDetailModel.studentAge ?? "",
                            style: TextStyle(
                                color: AppColor.black, fontSize: 16.sp)),
                        Text(studentDetailModel.studentGender ?? "",
                            style: TextStyle(
                                color: AppColor.black, fontSize: 16.sp)),
                        Text(studentDetailModel.studentSchool ?? "",
                            style: TextStyle(
                                color: AppColor.black, fontSize: 16.sp)),
                      ]),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColor.white, shape: BoxShape.circle),
                    child: Text(
                      studentDetailModel.studentName!.isNotEmpty
                          ? studentDetailModel.studentName!
                              .substring(0, 1)
                              .toUpperCase()
                          : '',
                      style:
                          TextStyle(color: AppColor.primary, fontSize: 26.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          height: 36.h,
          width: double.infinity.w,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return Button(
                    currentIndex: currentIndex,
                    index: index,
                    onTap: () => tabBarAction(diseases[index]),
                    text: diseases[index]);
              }),
        ),
        Container(
            alignment: Alignment.center,
            width: double.infinity.w,
            child: _buildImageContainer())
      ]),
    );
  }

  Widget _buildImageContainer() {
    String currentDisease = diseases[currentIndex];
    // String imagePath = diseaseImages[currentDisease] ?? '';
    Map<String, dynamic>? imageData = diseaseImages[currentDisease];
    if (imageData == null) {
      return const CircularProgressIndicator(); // or any other loading indicator
    }
    String? imagePath = imageData['path'];
    int score = imageData['score'] ?? 0;
    print(imageData);
    return imageData['path'] == null || imageData['path'].isEmpty
        ? Column(
            children: [
              emptyDiseaseDetail(context),
              SizedBox(height: 16.h),
              KButton(
                  isIcon: true,
                  onTap: () =>
                      _showBottomModel(context, disease: currentDisease),
                  text: "Take"),
            ],
          )
        // : isLoading
        //     ? CircularProgressIndicator()
        : Column(
            children: [
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12.r),
                        color: Colors.deepPurple.shade600,
                        dashPattern: const [8, 4],
                        padding: const EdgeInsets.all(4),
                        child: SizedBox(
                          height: 250.h,
                          width: double.infinity,
                          child: const SpinKitWaveSpinner(
                            color: Colors.white,
                            size: 200,
                            trackColor: Colors.deepPurple,
                            waveColor: Colors.deepPurple,
                          ),
                        ),
                      ),
                    )
                  : ImageContainer(
                      title: currentDisease,
                      path: imagePath ?? '',
                      disease: currentDisease,
                      diseaseImages: diseaseImages,
                      imagePickerUtils: imagePickerUtils,
                      updateImagePath: updateImagePath,
                      isLoading: isLoading,
                    ),
              SizedBox(height: 16.h),
              currentIndex == 0
                  ? KButton(
                      onTap: () {
                        if (currentIndex == 0) {
                          setState(() {
                            currentIndex++;
                          });
                        }
                      },
                      text: 'Next')
                  : currentIndex == 8
                      ? KButton(onTap: () {}, text: 'Submit')
                      : Row(
                          children: [
                            Expanded(
                              child: KButton(
                                  onTap: () {
                                    setState(() {
                                      currentIndex--;
                                    });
                                  },
                                  text: 'Back'),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: KButton(
                                  onTap: () {
                                    setState(() {
                                      currentIndex++;
                                    });
                                  },
                                  text: 'Next'),
                            )
                          ],
                        ),
              SizedBox(height: 16.h),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                color: Colors.deepPurple.shade600,
                dashPattern: const [8, 4],
                padding: const EdgeInsets.all(4),
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.deepPurple.shade100.withOpacity(.8),
                        highlightColor: Colors.white,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 36.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade100.withOpacity(.8),
                              borderRadius: BorderRadius.circular(12),
                            )))
                    : Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 36.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100.withOpacity(.8),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Score: $score',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
              )
            ],
          );
  }

  void updateImagePath(String disease, String? imagePath, int score) async {
    setState(() {
      isLoading = true; // Set loading state to true when updating image
    });
    await Future.delayed(const Duration(seconds: 2));
    if (imagePath != null) {
      setState(() {
        diseaseImages[disease] = {'path': imagePath, 'score': score};
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading =
            false; // Set loading state back to false if image update fails
      });
    }
  }

  Widget emptyDiseaseDetail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          DottedBorder(
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
              child: Icon(
                Icons.image,
                size: 60,
                color: Colors.deepPurple.shade400,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Please capture or select the image',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  void _showBottomModel(BuildContext context, {required String disease}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100.h,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              button(
                onPressed: () => captureImage(disease, ImageSource.camera),
                //  context.read<ScannerCubit>().captureCameraImage,
                icon: Icons.camera,
              ),
              button(
                onPressed: () => captureImage(disease, ImageSource.gallery),
                //  context.read<ScannerCubit>().captureGalleryImage,
                icon: Icons.photo_album,
              ),
            ],
          ),
        );
      },
    );
  }

  captureImage(String disease, ImageSource source) async {
    setState(() {
      isLoading = true;
    });
    XFile? imageFile = await _getImageFromSource(source);
    if (imageFile != null) {
      int score = 1 + DateTime.now().microsecondsSinceEpoch % 5;
      setState(() {
        diseaseImages[disease] = {'path': imageFile.path, 'score': score};
        // print(diseaseImages[disease] = imageFile.path);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    Navigator.pop(context);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<XFile?> _getImageFromSource(ImageSource source) async {
    XFile? imageFile;
    if (source == ImageSource.camera) {
      imageFile = await imagePickerUtils.cameraCapture();
    } else {
      imageFile = await imagePickerUtils.galleryCapture();
    }

    return imageFile;
  }

  void tabBarAction(String label) {
    switch (label) {
      case "Eye":
        if (diseaseImages['Eye'] != null &&
            diseaseImages['Eye']!['path'] != null) {
          setState(() => currentIndex = 0);
        }
        break;
      case "Mouth":
        if (diseaseImages['Eye'] != null &&
            diseaseImages['Eye']!['path'] != null) {
          setState(() => currentIndex = 1);
        }
        break;
      case "Tongue":
        if (diseaseImages['Mouth'] != null &&
            diseaseImages['Mouth']!['path'] != null) {
          setState(() => currentIndex = 2);
        }
        break;
      case "Gums":
        if (diseaseImages['Tongue'] != null &&
            diseaseImages['Tongue']!['path'] != null) {
          setState(() => currentIndex = 3);
        }
        break;
      case "Teeth":
        if (diseaseImages['Gums'] != null &&
            diseaseImages['Gums']!['path'] != null) {
          setState(() => currentIndex = 4);
        }
        break;
      case "Hair":
        if (diseaseImages['Teeth'] != null &&
            diseaseImages['Teeth']!['path'] != null) {
          setState(() => currentIndex = 5);
        }
        break;
      case "Skin":
        if (diseaseImages['Hair'] != null &&
            diseaseImages['Hair']!['path'] != null) {
          setState(() => currentIndex = 6);
        }
        break;
      case "Elbow":
        if (diseaseImages['Skin'] != null &&
            diseaseImages['Skin']!['path'] != null) {
          setState(() => currentIndex = 7);
        }
        break;
      case "Nail":
        if (diseaseImages['Elbow'] != null &&
            diseaseImages['Elbow']!['path'] != null) {
          setState(() => currentIndex = 8);
        }
        break;
    }
  }

  Widget generalInfo({required String key, required String value}) {
    return Row(
      children: [
        Text(key, style: TextStyle(color: AppColor.black, fontSize: 16.sp)),
        Text(value, style: TextStyle(color: AppColor.black, fontSize: 16.sp)),
      ],
    );
  }
}

Widget button({required VoidCallback onPressed, required IconData icon}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 50.w,
      height: 50.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1, color: Colors.deepPurple.shade100),
      ),
      child: Icon(icon, color: Colors.deepPurple),
    ),
  );
}

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final int currentIndex;
  final int index;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
    required this.currentIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        padding: const EdgeInsets.all(4),
        width: 70.w,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white70,
            borderRadius: currentIndex == index
                ? BorderRadius.circular(14.r)
                : BorderRadius.circular(10.r),
            border: currentIndex == index
                ? Border.all(color: Colors.deepPurple, width: 2)
                : null),
        child: Text(text,
            style: TextStyle(
                fontSize: 16.sp,
                color: currentIndex == index ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
