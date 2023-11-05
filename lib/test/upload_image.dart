import 'dart:developer';
import 'dart:io';

import 'package:firebase_app/widget/customize.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class FirebaseStorageSscreen extends StatefulWidget {
  const FirebaseStorageSscreen({super.key});

  @override
  State<FirebaseStorageSscreen> createState() => _FirebaseStorageSscreenState();
}

class _FirebaseStorageSscreenState extends State<FirebaseStorageSscreen> {
  String? urls = '';
  RxString imageName = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Image'),
      ),
      body: Center(
        child: Column(
          children: [
            if (urls!.isNotEmpty)
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image(image: NetworkImage(urls!)),
              ),
            CupertinoButton(
                color: Colors.red,
                child: const Text('Download image'),
                onPressed: () async {
                  final storageRef = FirebaseStorage.instance.ref();
                  final urlsImage = await storageRef
                      .child("image/test1.png")
                      .getDownloadURL();
                  setState(() {
                    urls = urlsImage;
                  });
                  log(urls!);
                }),
            CupertinoButton(
                color: Colors.blue,
                child: const Text('Upload Image'),
                onPressed: () async {
                  XFile selectedImage = await getImageFromGallary();
                  imageName.value =
                      DateTime.now().microsecondsSinceEpoch.toString();
                  const String childPath = '/image/';
                  openLoading();
                  final storageRef = await FirebaseStorage.instance
                      .ref()
                      .child(childPath)
                      .child("${imageName.value}.png")
                      .putFile(File(selectedImage.path))
                      .then((p0) async {
                    FirebaseStorage.instance
                        .ref()
                        .child(childPath)
                        .child("${imageName.value}.png")
                        .getDownloadURL()
                        .then((value) {
                      setState(() {
                        urls = value;
                      });
                    });
                    closeLoading();
                  });
                })
          ],
        ),
      ),
    );
  }

  getImageFromGallary() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    return file;
  }
}
