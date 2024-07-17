import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skin_disease_backup/core/utils/switch_case_controller.dart';
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
  bool isImageLoading = false;
  bool diseaseLoading = false;
  bool isStudentDetailLoading = false;
  bool isUpdate = false;
  bool isButtonLoading = false;
  String diseaseDescription = "";
  List<DiseaseDetailModel> diseaseDetailModel = [];
  StudentDetailModel studentDetailModel = StudentDetailModel();

  @override
  void initState() {
    initialStudentDetail();

    super.initState();
  }

  initialStudentDetail() {
    setState(() => isStudentDetailLoading = true);

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
                studentDetailModel = r;

                isStudentDetailLoading = false;
              });
            }));
  }

  initialDiseaseDetail() {
    setState(() => diseaseLoading = true);

    ref
        .read(diseaseDetailProvider.notifier)
        .getDiseaseDetail(studentDetailModel.id ?? 0)
        .then((res) => res.fold((l) {
              setState(() {
                log(l.message);
                diseaseLoading = false;
              });
            }, (r) {
              setState(() {
                diseaseDetailModel = r;
                diseaseLoading = false;
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const HomeAppBar(title: "Clinical Assessment", isHome: true),
        SizedBox(height: 16.h),
        isStudentDetailLoading
            ? const CircularProgressIndicator()
            : StudentDetailContaner(
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
                                selectGenderImage:
                                    widget.selectedGenderImage ?? "",
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: ListView.builder(
                key: ValueKey<int>(currentIndex),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: diseases.length,
                itemBuilder: (context, index) {
                  return Button(
                      currentIndex: currentIndex,
                      index: index,
                      onTap: () {
                        // setState(() => currentIndex = index);
                        tabBarAction(diseases[index]);
                      },
                      text: diseases[index]);
                }),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16).w,
            alignment: Alignment.center,
            child: _buildImageContainer()),
        SizedBox(height: 50.h),
      ]),
    );
  }

  Widget _buildImageContainer() {
    String currentDisease = diseases[currentIndex];

    Map<String, dynamic>? imageData = diseaseImages[currentDisease];

    if (imageData == null) {
      return const CircularProgressIndicator(); // or any other loading indicator
    }
    String? imagePath = imageData['path'];
    var currentDiseaseDetail = diseaseDetailModel.firstWhere(
      (diseaseDetail) => diseaseDetail.diseaseName == currentDisease,
      orElse: () =>
          DiseaseDetailModel(diseaseName: currentDisease, diseaseImage: null),
    );
    isUpdate = currentDiseaseDetail != null &&
        currentDiseaseDetail.diseaseImage != null;
    bool isNextEnabled = imagePath != null &&
        imagePath.isNotEmpty &&
        getDiseaseControllerWithSwitch(currentIndex).text.isNotEmpty;
    int score =
        int.tryParse(getDiseaseControllerWithSwitch(currentIndex).text) ?? 0;
    diseaseDescription = getDiseaseDescription(currentDisease, score);
    return imageData['path'] == null || imageData['path'].isEmpty
        ? Column(
            children: [
              GestureDetector(
                  onTap: () =>
                      _showBottomModel(context, disease: currentDisease),
                  child: EmptyImageContainer(
                    diseaseName: getDiseaseNameWithSwitch(currentIndex),
                  )),
              SizedBox(height: 16.h),
            ],
          )
        : Column(
            children: [
              isImageLoading
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
                  : Stack(
                      children: [
                        ImageContainer(
                          path: imagePath ?? '',
                          disease: currentDisease,
                          imagePickerUtils: imagePickerUtils,
                          isLoading: isImageLoading,
                          scoreController:
                              getDiseaseControllerWithSwitch(currentIndex),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(6.r)),
                            child: GestureDetector(
                              onTap: () {
                                initialDiseaseDetail();
                                _showBottomModel(context,
                                    disease: currentDisease);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(color: AppColor.white),
                                  ),
                                  SizedBox(width: 8.w),
                                  const Icon(Icons.edit, color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  ScoreContainer(
                      child: Text(
                    'Score:',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  )),
                  SizedBox(width: 8.w),
                  ScoreContainer(
                      child: TextField(
                    controller: getDiseaseControllerWithSwitch(currentIndex),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Enter Score"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RangeTextInputFormatter(min: 1, max: 10),
                    ],
                    onChanged: (value) {
                      setState(() {
                        int newScore = int.tryParse(value) ?? 0;
                        diseaseDescription =
                            getDiseaseDescription(currentDisease, newScore);
                      });
                    },
                  ))
                ],
              ),
              SizedBox(height: 8.h),
              getDiseaseControllerWithSwitch(currentIndex).text == ""
                  ? const SizedBox()
                  : Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Description: ',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.red),
                          ),
                          TextSpan(
                            text: diseaseDescription,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 8.h),
              if (isUpdate)
                isButtonLoading
                    ? const CircularProgressIndicator()
                    : KButton(
                        onTap: isNextEnabled
                            ? () async {
                                setState(() => isButtonLoading = true);
                                Uint8List? imageBytes = diseaseImages[
                                    diseases[currentIndex]]!['bytes'];
                                DiseaseUpdateEntities diseaseUpdateEntities =
                                    DiseaseUpdateEntities(
                                        id: getCustomId(diseases[currentIndex]),
                                        diseaseName: getDiseaseNameWithSwitch(
                                            currentIndex),
                                        diseaseScore: int.parse(
                                            getDiseaseControllerWithSwitch(
                                                    currentIndex)
                                                .text),
                                        diseaseImage: imageBytes);
                                final response = ref
                                    .read(homeProvider.notifier)
                                    .updateDisease(diseaseUpdateEntities);
                                response.then((response) => response.fold((l) {
                                      log(l.message.toString());
                                      setState(() => isButtonLoading = false);
                                    }, (r) {
                                      Future.delayed(const Duration(seconds: 2))
                                          .then((_) {
                                        AppAlert.displaySnackBar(context,
                                            isSuccess: true,
                                            message: "Update successful");
                                        setState(() => isButtonLoading = false);
                                        log("Update successful");
                                      });
                                    }));
                              }
                            : () {},
                        text: "Update",
                        color: isNextEnabled
                            ? Colors.deepPurple.shade600
                            : Colors.grey,
                      ),
              if (!isUpdate)
                isButtonLoading
                    ? const CircularProgressIndicator()
                    : KButton(
                        onTap: isNextEnabled
                            ? () async {
                                setState(() => isButtonLoading = true);
                                Uint8List? imageBytes = diseaseImages[
                                    diseases[currentIndex]]!['bytes'];
                                DiseaseEntities diseaseEntities =
                                    DiseaseEntities(
                                  diseaseName:
                                      getDiseaseNameWithSwitch(currentIndex),
                                  diseaseScore: int.parse(
                                      getDiseaseControllerWithSwitch(
                                              currentIndex)
                                          .text),
                                  diseaseImage: imageBytes,
                                );
                                ref
                                    .read(homeProvider.notifier)
                                    .addDisease(diseaseEntities)
                                    .then((response) => response.fold((l) {
                                          log(l.message.toString());
                                          setState(
                                              () => isButtonLoading = false);
                                        }, (r) {
                                          initialDiseaseDetail();
                                          Future.delayed(
                                                  const Duration(seconds: 2))
                                              .then((_) {
                                            AppAlert.displaySnackBar(context,
                                                isSuccess: true,
                                                message:
                                                    "${getDiseaseNameWithSwitch(currentIndex)} Add successfull");
                                            setState(() {
                                              isButtonLoading = false;
                                              currentIndex++;
                                            });
                                            log("Add successfull");
                                          });
                                        }));
                              }
                            : () {},
                        text: "Done",
                        color: isNextEnabled
                            ? Colors.deepPurple.shade600
                            : Colors.grey,
                      ),
              SizedBox(height: 8.h),
              if (currentIndex == 8)
                KButton(
                    onTap: isUpdate
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ResultScreen(
                                        id: studentDetailModel.id ?? 0)));
                          }
                        : () {},
                    text: 'Submit',
                    color: isUpdate ? Colors.deepPurple.shade600 : Colors.grey)
            ],
          );
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
                icon: Icons.camera,
              ),
              CaptureImageButton(
                onPressed: () => captureImage(disease, ImageSource.gallery),
                icon: Icons.photo_album,
              ),
            ],
          ),
        );
      },
    );
  }

  captureImage(String disease, ImageSource source) async {
    setState(() => isImageLoading = true);
    XFile? imageFile = await _getImageFromSource(source);
    if (imageFile != null) {
      Uint8List imageBytes = await imageFile.readAsBytes();
      setState(() {
        diseaseImages[disease] = {'path': imageFile.path, 'bytes': imageBytes};
        if (isUpdate) {
          getDiseaseControllerWithSwitch(currentIndex).clear();
        }
      });
    } else {
      setState(() => isImageLoading = false);
    }
    if (!mounted) return;
    Navigator.pop(context);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isImageLoading = false);
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
            diseaseImages['Eye']!['bytes'] != null) {
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
