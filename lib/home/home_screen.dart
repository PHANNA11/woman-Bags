import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Auth/login_screen.dart';
import 'package:firebase_app/data/firebase_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference dataRef = FirebaseFirestore.instance
      .collection(FireBaseAPI().productCollectionName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance
                        .signOut()
                        .then((value) => Get.offAll(() => const LoginScreen()));
                  },
                  title: const Text('Sign Out'),
                  trailing: const Icon(Icons.logout_outlined),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // ignore: prefer_const_constructors
            return Center(
              child: const Icon(
                Icons.info,
                color: Colors.red,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  log(data.toString());
                  return productCard(proData: data);
                });
          }
        },
      ),
    );
  }

  Widget productCard({Map? proData}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: proData![FireBaseAPI().productImage.toString()],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(proData[FireBaseAPI().productName]),
                  Text(
                    "\$ ${proData[FireBaseAPI().productPrice]}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Spacer(),
                  Text('Color: ${proData[FireBaseAPI().productColor]}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
