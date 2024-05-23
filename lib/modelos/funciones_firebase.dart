import 'package:delibery_app/modelos/models/image_models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FuncionesFirebase {
  Future<ImageModel> uploadImage(File image, String type) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('$type/$type${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(image);

      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return ImageModel(url: downloadUrl);
    } catch (e) {
      return ImageModel(errorMessage: e.toString());
    }
  }
}
