import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> cameraCapture() async {
    final XFile? file =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    return file;
  }

  Future<XFile?> galleryCapture() async {
    final XFile? file =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    return file;
  }
}
