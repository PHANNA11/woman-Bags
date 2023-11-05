import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../method/firenbase_storage_method.dart';

class FirebaseStorageSscreen extends StatefulWidget {
  const FirebaseStorageSscreen({super.key});

  @override
  State<FirebaseStorageSscreen> createState() => _FirebaseStorageSscreenState();
}

class _FirebaseStorageSscreenState extends State<FirebaseStorageSscreen> {
  String? urls = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Image'),
      ),
      body: Column(
        children: [
          if (urls!.isNotEmpty)
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image(image: NetworkImage(urls!)),
            ),
          CupertinoButton(
              child: Text('Get Data'),
              onPressed: () async {
                final storageRef = FirebaseStorage.instance.ref();
                final urlsImage =
                    await storageRef.child("image/test1.png").getDownloadURL();
                setState(() {
                  urls = urlsImage;
                });
                log(urls!);
              })
        ],
      ),
    );
  }
}
