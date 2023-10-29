import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Auth/login_screen.dart';
import 'package:firebase_app/data/firebase_field.dart';
import 'package:firebase_app/home/filter_screen.dart';
import 'package:firebase_app/home/products/view/add_edit_product.dart';
import 'package:firebase_app/home/products/view/edit_product.dart';
import 'package:firebase_app/widget/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/product_card_custome.dart';
import 'products/model/product_model.dart';

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
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .then((value) => Get.offAll(() => const LoginScreen()));
                },
                title: const Text('Sign Out'),
                trailing: const Icon(Icons.logout_outlined),
              ),
              const Divider(color: Colors.black),
              ListTile(
                onTap: () async {
                  Get.to(() => AddEditProductScreen());
                },
                title: const Text('Add Product'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(color: Colors.black),
              ListTile(
                onTap: () async {
                  Get.to(() => const EditProductScreen());
                },
                title: const Text('Edit Product'),
                trailing: const Icon(Icons.arrow_forward_ios),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextFieldWidget(
          onTap: () {
            Get.to(() => const SearchScreen());
          },
          readOnly: true,
          height: 50,
          hindText: 'Search product',
          sufficIconData: Icons.search,
        ),
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
                  return ProductCardCustome(
                    product: ProductModel.fromQuerySnapshot(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>),
                    docId: snapshot.data!.docs[index].id,
                    isSlidable: false,
                  );
                });
          }
        },
      ),
    );
  }
}
