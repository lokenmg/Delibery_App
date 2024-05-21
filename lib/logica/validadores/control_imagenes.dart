import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ControlImagenes {
  File? _image;

  Future<File?> seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      return _image;
    } else {
      return null;
    }
  }

  Future<File?> tomarFoto() async {
    return null;
  }
}
