import 'dart:developer';
import 'dart:io';

import 'package:firebase_app/home/products/view/add_edit_product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/customize.dart';

class FirebaseStorageMethod {
  //sReference get firestorage => FirebaseStorage.instance.ref();

  Future<String> uploadImageToFirebase() async {
    XFile selectedImage = await getImageFromGallary();
    RxString imageName = DateTime.now().microsecondsSinceEpoch.toString().obs;
    const String childPath = '/image/';

    await FirebaseStorage.instance
        .ref()
        .child(childPath)
        .child("${imageName.value}.png")
        .putFile(File(selectedImage.path))
        .then((p0) async {
      return downloadImage(childPath: childPath, imageName: imageName.value);
    });
    return '';
  }

  downloadImage(
      {required String? childPath, required String? imageName}) async {
    FirebaseStorage.instance
        .ref()
        .child(childPath!)
        .child("$imageName.png")
        .getDownloadURL()
        .then((value) {
      linkController!.value = value;
    });
  }

  getImageFromGallary() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    return file;
  }
}
