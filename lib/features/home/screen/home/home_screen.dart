import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_disease_backup/config/enum/enum.dart';
import 'package:skin_disease_backup/core/utils/image_picker_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePickerUtils imagePickerUtils = ImagePickerUtils();
  String eyeImage = '';
  String mouthImage = '';
  String nailImage = '';
  String skinImage = '';

  // Disease currentDisease = Disease.Eye;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Skin Disease Detector',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          eyeImage.isNotEmpty
              ? ImageContainer(title: Disease.Eye.name, path: eyeImage)
              : Button(
                  onTap: () => showBottomModel(context, disease: Disease.Eye,
                          onPressedForCamera: () async {
                        XFile? eyeImageFile =
                            await imagePickerUtils.cameraCapture();
                        if (eyeImageFile != null) {
                          setState(() {
                            eyeImage = eyeImageFile.path;
                            // currentDisease = Disease.Eye;
                          });
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }, onPressedForGallery: () async {
                        XFile? eyeImageFile =
                            await imagePickerUtils.galleryCapture();
                        if (eyeImageFile != null) {
                          setState(() {
                            eyeImage = eyeImageFile.path;
                            // currentDisease = Disease.Eye;
                          });
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }),
                  text: 'Eye'),
          const SizedBox(height: 16),
          mouthImage.isNotEmpty
              ? ImageContainer(title: Disease.Mouth.name, path: mouthImage)
              : eyeImage.isNotEmpty
                  ? Button(
                      onTap: () =>
                          showBottomModel(context, disease: Disease.Mouth,
                              onPressedForCamera: () async {
                            XFile? mouthImageFile =
                                await imagePickerUtils.cameraCapture();
                            if (mouthImageFile != null) {
                              setState(() {
                                mouthImage = mouthImageFile.path;
                                // currentDisease = Disease.Mouth;
                              });
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }, onPressedForGallery: () async {
                            XFile? mouthImageFile =
                                await imagePickerUtils.galleryCapture();
                            if (mouthImageFile != null) {
                              setState(() {
                                mouthImage = mouthImageFile.path;
                                // currentDisease = Disease.Mouth;
                              });
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }),
                      text: 'Mouth')
                  : const SizedBox(),
          const SizedBox(height: 16),
          nailImage.isNotEmpty
              ? ImageContainer(title: Disease.Nail.name, path: nailImage)
              : mouthImage.isNotEmpty
                  ? Button(
                      onTap: () =>
                          showBottomModel(context, disease: Disease.Nail,
                              onPressedForCamera: () async {
                            XFile? nailImageFile =
                                await imagePickerUtils.cameraCapture();
                            if (nailImageFile != null) {
                              setState(() {
                                nailImage = nailImageFile.path;
                                // currentDisease = Disease.Nail;
                              });
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }, onPressedForGallery: () async {
                            XFile? nailImageFile =
                                await imagePickerUtils.galleryCapture();
                            if (nailImageFile != null) {
                              setState(() {
                                nailImage = nailImageFile.path;
                                // currentDisease = Disease.Nail;
                              });
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }),
                      text: "Nail")
                  : const SizedBox(),
          const SizedBox(height: 16),
          skinImage.isNotEmpty
              ? ImageContainer(title: Disease.Skin.name, path: skinImage)
              : nailImage.isNotEmpty
                  ? Button(
                      onTap: () =>
                          showBottomModel(context, disease: Disease.Skin,
                              onPressedForCamera: () async {
                            XFile? skinImageFile =
                                await imagePickerUtils.cameraCapture();
                            if (skinImageFile != null) {
                              setState(() {
                                skinImage = skinImageFile.path;
                              });
                            }
                            Navigator.pop(context);
                          }, onPressedForGallery: () async {
                            XFile? skinImageFile =
                                await imagePickerUtils.galleryCapture();
                            if (skinImageFile != null) {
                              setState(() {
                                skinImage = skinImageFile.path;
                              });
                            }
                            Navigator.pop(context);
                          }),
                      text: Disease.Skin.name)
                  : const SizedBox(),
          const SizedBox(height: 16),
          skinImage.isNotEmpty
              ? Button(onTap: () {}, text: "Submit")
              : const SizedBox()
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.title,
    required this.path,
  });
  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        if (path.isNotEmpty)
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: Colors.deepPurple.shade100),
              image: DecorationImage(
                image: FileImage(File(path)),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          const Text(
            'No Image Available',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const Button({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade600,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}

void showBottomModel(BuildContext context,
    {required Disease disease,
    required VoidCallback onPressedForCamera,
    required VoidCallback onPressedForGallery}) {
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
              onPressed: onPressedForCamera,
              //  context.read<ScannerCubit>().captureCameraImage,
              icon: Icons.camera,
            ),
            button(
              onPressed: onPressedForGallery,
              //  context.read<ScannerCubit>().captureGalleryImage,
              icon: Icons.photo_album,
            ),
          ],
        ),
      );
    },
  );
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
