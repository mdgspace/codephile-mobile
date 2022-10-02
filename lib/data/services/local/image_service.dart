import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Uses [ImagePicker] and [ImageCropper] packages to pick and crop a photo from the phone gallery
class ImageService {
  /// Service initializer
  static void init() {
    _imagePicker = ImagePicker();
    _imageCropper = ImageCropper();
  }

  // Data
  /// The [ImagePicker] instance which is used to access the image methods.
  static late final ImagePicker _imagePicker;

  /// The [ImageCropper] instance which is used to access the image methods.
  static late final ImageCropper _imageCropper;

  // Methods
  /// Allows the user to pick and crop a picture to use as their profile image.
  static Future<File?> pickProfileImage() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    final croppedImage = await _imageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
      cropStyle: CropStyle.circle,
      compressFormat: ImageCompressFormat.png,
    );

    File? file;
    if (croppedImage != null) {
      file = File(croppedImage.path);
    }

    return file;
  }
}
