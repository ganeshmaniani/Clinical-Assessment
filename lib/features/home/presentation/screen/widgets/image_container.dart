import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_disease_backup/core/utils/image_picker_utils.dart';
import 'package:skin_disease_backup/features/home/presentation/screen/home_ui.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    super.key,
    required this.title,
    required this.path,
    required this.disease,
    required this.imagePickerUtils,
    required this.diseaseImages,
    required this.updateImagePath,
    required this.isLoading,
  });
  final String title;
  final String path;
  final String disease;
  final ImagePickerUtils imagePickerUtils;
  final Map<String, dynamic> diseaseImages;
  final Function(String, String, int) updateImagePath;
  final bool isLoading;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (widget.path.isNotEmpty)
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _showBottomModel(context, disease: widget.disease);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 250.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border:
                        Border.all(width: 1, color: Colors.deepPurple.shade100),
                    image: DecorationImage(
                      image: FileImage(File(widget.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              widget.isLoading
                  ? const SizedBox()
                  : Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomModel(context, disease: widget.disease);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Retake',
                                style: textTheme.labelLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              const Icon(Icons.replay, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          )
        else
          Text('No Image Available', style: textTheme.bodyMedium),
      ],
    );
  }

  void _showBottomModel(BuildContext context, {required String disease}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120.h,
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

  Future<void> captureImage(String disease, ImageSource source) async {
    XFile? imageFile = await _getImageFromSource(source);
    if (imageFile != null) {
      log('New image path: ${imageFile.path}');
      final int score = _generateRandomScore();
      widget.updateImagePath(disease, imageFile.path, score);
    } else {
      log('Failed to capture image');
    }
    Navigator.pop(context);
  }

  Future<XFile?> _getImageFromSource(ImageSource source) async {
    XFile? imageFile;
    if (source == ImageSource.camera) {
      imageFile = await widget.imagePickerUtils.cameraCapture();
    } else {
      imageFile = await widget.imagePickerUtils.galleryCapture();
    }
    return imageFile;
  }

  int _generateRandomScore() {
    return 1 + DateTime.now().millisecondsSinceEpoch % 5;
  }
}
