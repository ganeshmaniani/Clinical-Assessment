import 'dart:developer' as devtools;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_disease_backup/features/result/screen/result_screen.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../../../../core/utils/image_picker_utils.dart';
import '../../../../core/widgets/button.dart';
import '../home/presentation/screen/widgets/image_container.dart';

class ExampleTflite extends StatefulWidget {
  const ExampleTflite({super.key});

  @override
  State<ExampleTflite> createState() => _ExampleTfliteState();
}

class _ExampleTfliteState extends State<ExampleTflite> {
  final List diseases = ["Eye", "Mouth", "Nail", "Skin"];
  final ImagePickerUtils imagePickerUtils = ImagePickerUtils();
  Map<String, Map<String, dynamic>> diseaseImages = {
    "Eye": {},
    "Mouth": {},
    "Nail": {},
    "Skin": {}
  };
  int currentIndex = 0;
  bool isLoading = false;
  String output = '';
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Skin Disease Detector',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 60,
          width: double.infinity,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Button(
                        currentIndex: currentIndex,
                        index: index,
                        onTap: () => tabBarAction(diseases[index]),
                        text: diseases[index]),
                    Visibility(
                        visible: currentIndex == index,
                        child: Container(
                          height: 5,
                          width: 12,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple, shape: BoxShape.circle),
                        )),
                  ],
                );
              }),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30),
            width: double.infinity,
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
    String? imageName = imageData['name'];
    print(imageData);
    return imagePath == null || imagePath.isEmpty
        ? Column(
            children: [
              emptyDiseaseDetail(context),
              const SizedBox(height: 32),
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
                  ? const SizedBox(
                      height: 350,
                      child: SpinKitWaveSpinner(
                        color: Colors.white,
                        size: 200,
                        trackColor: Colors.deepPurple,
                        waveColor: Colors.deepPurple,
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
              const SizedBox(height: 32),
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
                  : currentIndex == 3
                      ? Row(
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: KButton(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ResultScreen()));
                                  },
                                  text: 'Submit'),
                            )
                          ],
                        )
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
                            const SizedBox(width: 16),
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
              const SizedBox(height: 16),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                color: Colors.deepPurple.shade600,
                dashPattern: const [8, 4],
                padding: const EdgeInsets.all(4),
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.deepPurple.shade100.withOpacity(.8),
                        highlightColor: Colors.white,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade100.withOpacity(.8),
                              borderRadius: BorderRadius.circular(12),
                            )))
                    : Container(
                        // width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.all(8),
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100.withOpacity(.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Result: $output',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            color: Colors.deepPurple.shade600,
            dashPattern: const [8, 4],
            padding: const EdgeInsets.all(4),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100.withOpacity(.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.image,
                size: 60,
                color: Colors.deepPurple.shade400,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Please capture or select the image'),
        ],
      ),
    );
  }

  void _showBottomModel(BuildContext context, {required String disease}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120,
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
      var recognitions = await Tflite.runModelOnImage(
          path: imageFile.path,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 2,
          asynch: true);
      if (recognitions == null) {
        devtools.log("recognitions is Null");
        return;
      }
      devtools.log(recognitions.toString());
      setState(() {
        output = recognitions[0]['label'].toString();
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
      case "Nail":
        if (diseaseImages['Mouth'] != null &&
            diseaseImages['Mouth']!['path'] != null) {
          setState(() => currentIndex = 2);
        }
        break;
      case "Skin":
        if (diseaseImages['Nail'] != null &&
            diseaseImages['Nail']!['path'] != null) {
          setState(() => currentIndex = 3);
        }
        break;
    }
  }
}

Widget button({required VoidCallback onPressed, required IconData icon}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 70,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
        padding: const EdgeInsets.all(8),
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white70,
            borderRadius: currentIndex == index
                ? BorderRadius.circular(14)
                : BorderRadius.circular(10),
            border: currentIndex == index
                ? Border.all(color: Colors.deepPurple, width: 2)
                : null),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                color: currentIndex == index ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
