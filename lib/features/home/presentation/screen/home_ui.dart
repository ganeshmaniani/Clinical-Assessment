import 'dart:developer';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_disease_backup/features/home/home.dart';
import 'package:skin_disease_backup/features/home/presentation/presentation.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class TabHomeScreen extends ConsumerStatefulWidget {
  final String? selectedGenderImage;
  const TabHomeScreen({super.key, this.selectedGenderImage});

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
  final TextEditingController eyeController = TextEditingController();
  final TextEditingController mouthController = TextEditingController();
  final TextEditingController tongueController = TextEditingController();
  final TextEditingController gumsController = TextEditingController();
  final TextEditingController teethController = TextEditingController();
  final TextEditingController hairController = TextEditingController();
  final TextEditingController skinController = TextEditingController();
  final TextEditingController elbowController = TextEditingController();
  final TextEditingController nailController = TextEditingController();
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
  bool isUpdateButtonEnable = false;
  bool isDoneClicked = false;
  List<DiseaseDetailModel> diseaseDetailModel = [];
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
              setState(() => isLoading = false);
            }, (r) {
              setState(() {
                isStudentDetailLoading = false;
                studentDetailModel = r;

                isStudentDetailLoading = false;
              });
              setState(() => isLoading = false);
            }));
  }

  initialDiseaseDetail() {
    setState(() => isLoading = true);

    ref
        .read(diseaseDetailProvider.notifier)
        .getDiseaseDetail(studentDetailModel.id ?? 0)
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
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const HomeAppBar(title: "Clinical Assessment", isHome: true),
        SizedBox(height: 16.h),
        StudentDetailContaner(
          studentName: studentDetailModel.studentName ?? "",
          studentAge: studentDetailModel.studentAge ?? "",
          studentGender: studentDetailModel.studentGender ?? "",
          schoolName: studentDetailModel.studentSchool ?? '',
          isHome: true,
          editFunction: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RegisterEditUI(
                          selectGenderImage: widget.selectedGenderImage ?? "",
                          studentDetailModel: studentDetailModel,
                        ))).whenComplete(() => initialStudentDetail());
          },
          deleteFunction: () async {
            showAlertBox(context,
                title: "Delete Student Detail",
                description: "Are you sure?",
                btnCancelText: "No",
                btnOkText: "Yes",
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide, btnOkOnPress: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var studentId = prefs.getInt(DBKeys.dbColumnId);
              log("StudentId:${studentId.toString()}");
              prefs.remove(DBKeys.dbColumnId);
              Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterUI()),
                  (route) => false);
            }, btnCancelOnPress: () {});
          },
        ),
        SizedBox(height: 16.h),
        Container(
          margin: const EdgeInsets.only(left: 16).w,
          height: 36.h,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return Button(
                    currentIndex: currentIndex,
                    index: index,
                    onTap: () {
                      tabBarAction(diseases[index]);
                      log("Click");
                    },
                    text: diseases[index]);
              }),
        ),
        SizedBox(height: 16.h),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16).w,
            alignment: Alignment.center,
            // width: double.infinity.w,
            child: _buildImageContainer()),
        SizedBox(height: 50.h),
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
    // score = imageData['score'] ?? 0;
    bool isNextEnabled = imagePath != null &&
        imagePath.isNotEmpty &&
        getDiseaseControllerWithSwitch(currentIndex).text.isNotEmpty;

    return imageData['path'] == null || imageData['path'].isEmpty
        ? Column(
            children: [
              const EmptyImageContainer(),
              SizedBox(height: 16.h),
              KButton(
                  isIcon: true,
                  onTap: () =>
                      _showBottomModel(context, disease: currentDisease),
                  text: "Take"),
            ],
          )
        : Column(
            children: [
              isLoading
                  ? DottedBorder(
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
                    )
                  : ImageContainer(
                      title: currentDisease,
                      path: imagePath ?? '',
                      disease: currentDisease,
                      diseaseImages: diseaseImages,
                      imagePickerUtils: imagePickerUtils,
                      updateImagePath: updateImagePath,
                      isLoading: isLoading,
                      scoreController: eyeController,
                    ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
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
                        child: Text(
                          'Score:',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
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
                          child: TextField(
                            controller:
                                getDiseaseControllerWithSwitch(currentIndex),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "00"),
                            onChanged: (value) {
                              setState(() {});
                            },
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              KButton(
                onTap: isNextEnabled
                    ? () async {
                        Uint8List? imageBytes =
                            diseaseImages[diseases[currentIndex]]!['bytes'];
                        DiseaseEntities diseaseEntities = DiseaseEntities(
                          diseaseName: getDiseaseNameWithSwitch(currentIndex),
                          diseaseScore: int.parse(
                              getDiseaseControllerWithSwitch(currentIndex)
                                  .text),
                          diseaseImage: imageBytes,
                        );
                        ref
                            .read(homeProvider.notifier)
                            .addDisease(diseaseEntities)
                            .then((response) => response.fold(
                                    (l) => log(l.message.toString()), (r) {
                                  log("Add successfullfully");
                                  setState(() {
                                    isDoneClicked = true;
                                    isUpdateButtonEnable = true;
                                  });
                                }));
                      }
                    : () {},
                text: "Done",
                color: isNextEnabled ? Colors.deepPurple.shade600 : Colors.grey,
              ),
              KButton(
                  onTap: isUpdateButtonEnable ? () async {} : () {},
                  text: "Update"),
              SizedBox(height: 8.h),
              // currentIndex == 0
              //     ? KButton(
              //         onTap: isUpdateButtonEnable
              //             ? () {
              //                 if (currentIndex == 0) {
              //                   setState(() {
              //                     currentIndex++;
              //                     isDoneClicked = false;
              //                     isUpdateButtonEnable =
              //                         getDiseaseControllerWithSwitch(
              //                                 currentIndex)
              //                             .text
              //                             .isNotEmpty;
              //                   });
              //                 }
              //               }
              //             : () {},
              //         text: 'Next',
              //         color: isUpdateButtonEnable
              //             ? Colors.deepPurple.shade600
              //             : Colors.grey)
              //     :
              if (currentIndex == 8)
                KButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ResultScreen(
                                  id: studentDetailModel.id ?? 0)));
                    },
                    text: 'Submit')
              // : Row(
              //     children: [
              //       if (currentIndex > 0)
              //         Expanded(
              //           child: KButton(
              //               onTap: () {
              //                 setState(() {
              //                   currentIndex--;
              //                   isDoneClicked = false;
              //                   isUpdateButtonEnable =
              //                       getDiseaseControllerWithSwitch(
              //                               currentIndex)
              //                           .text
              //                           .isNotEmpty;
              //                 });
              //               },
              //               text: 'Back'),
              //         ),
              //       SizedBox(width: 16.w),
              //       if (currentIndex < diseases.length - 1)
              //         Expanded(
              //           child: KButton(
              //               onTap: isUpdateButtonEnable
              //                   ? () {
              //                       setState(() {
              //                         currentIndex++;
              //                         isDoneClicked = false;
              //                         isUpdateButtonEnable =
              //                             getDiseaseControllerWithSwitch(
              //                                     currentIndex)
              //                                 .text
              //                                 .isNotEmpty;
              //                       });
              //                     }
              //                   : () {},
              //               text: 'Next',
              //               color: isUpdateButtonEnable
              //                   ? Colors.deepPurple.shade600
              //                   : Colors.grey),
              //         )
              //     ],
              //   ),
            ],
          );
  }

  String getDiseaseNameWithSwitch(int index) {
    switch (index) {
      case 0:
        return "Eye";
      case 1:
        return "Mouth";
      case 2:
        return "Tongue";
      case 3:
        return "Gums";
      case 4:
        return "Teeth";
      case 5:
        return "Hair";
      case 6:
        return "Skin";
      case 7:
        return "Elbow";
      case 8:
        return "Nail";
      // case 9:
      //   return "Eye";

      default:
        return "Unknown";
    }
  }

  TextEditingController getDiseaseControllerWithSwitch(int index) {
    switch (index) {
      case 0:
        return eyeController;
      case 1:
        return mouthController;
      case 2:
        return tongueController;
      case 3:
        return gumsController;
      case 4:
        return teethController;
      case 5:
        return hairController;
      case 6:
        return skinController;
      case 7:
        return elbowController;
      case 8:
        return nailController;

      default:
        return TextEditingController();
    }
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
              CaptureImageButton(
                onPressed: () => captureImage(disease, ImageSource.camera),
                //  context.read<ScannerCubit>().captureCameraImage,
                icon: Icons.camera,
              ),
              CaptureImageButton(
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
      // int score = 1 + DateTime.now().microsecondsSinceEpoch % 5;
      Uint8List imageBytes = await imageFile.readAsBytes();
      setState(() {
        diseaseImages[disease] = {
          'path': imageFile.path,
          'bytes': imageBytes
          // 'score': int.parse(scoreController.text)
        };
        // print(diseaseImages[disease] = imageFile.path);
      });
      // DiseaseEntities diseaseEntities = DiseaseEntities(
      //     diseaseName: disease, diseaseScore: int.parse(scoreController.text));
      // ref.read(homeProvider.notifier).addDisease(diseaseEntities).then(
      //     (response) => response.fold((l) => log(l.message.toString()), (r) {
      //           log("Add successfullfully");
      //         }));
    } else {
      setState(() {
        isLoading = false;
      });
    }
    if (!mounted) return;
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
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          backgroundColor: onPressed != null
              ? AppColor.primary
              : AppColor.primary.withOpacity(.1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: onPressed != null ? AppColor.white : AppColor.black,
          ),
        ),
      ),
    );
  }
}
