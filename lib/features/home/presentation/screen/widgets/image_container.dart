  import 'dart:developer';
  import 'dart:io';

  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:image_picker/image_picker.dart';

  import '../../../../../core/utils/utils.dart';
  import '../../../../features.dart';

  class ImageContainer extends ConsumerStatefulWidget {
    const ImageContainer({
      super.key,
      required this.title,
      required this.path,
      required this.disease,
      required this.imagePickerUtils,
      required this.diseaseImages,
      required this.updateImagePath,
      required this.isLoading,
      required this.scoreController,
    });
    final String title;
    final String path;
    final String disease;
    final ImagePickerUtils imagePickerUtils;
    final Map<String, dynamic> diseaseImages;
    final Function(String, String, int) updateImagePath;
    final bool isLoading;
    final TextEditingController scoreController;

    @override
    ConsumerState<ImageContainer> createState() => _ImageContainerConsumerState();
  }

  class _ImageContainerConsumerState extends ConsumerState<ImageContainer> {
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
                    // margin: const EdgeInsets.symmetric(horizontal: 16),
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
                CaptureImageButton(
                  onPressed: () {
                    widget.scoreController.clear();
                    captureImage(disease, ImageSource.camera);
                  },
                  //  context.read<ScannerCubit>().captureCameraImage,
                  icon: Icons.camera,
                ),
                CaptureImageButton(
                  onPressed: () {
                    widget.scoreController.clear();
                    captureImage(disease, ImageSource.gallery);
                  },
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

        DiseaseUpdateEntities updateEntities = DiseaseUpdateEntities(
            id: getCustomId(disease), diseaseName: disease, diseaseScore: score);
        ref.read(homeProvider.notifier).updateDisease(updateEntities).then(
            (response) => response.fold((l) => log(l.message.toString()), (r) {
                  log("Updated Successfully");
                }));
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

    int getCustomId(String disease) {
      switch (disease) {
        case 'Eye':
          return 1;
        case 'Mouth':
          return 2;
        case 'Tongue':
          return 3;
        case 'Gums':
          return 4;
        case 'Teeth':
          return 5;
        case 'Hair':
          return 6;
        case 'Skin':
          return 7;
        case 'Elbow':
          return 8;
        case 'Nail':
          return 9;
        default:
          return -1; // Return -1 for unknown diseases
      }
    }
  }
