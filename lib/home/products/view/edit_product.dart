import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/home/products/model/product_model.dart';
import 'package:firebase_app/method/firebase_method.dart';
import 'package:firebase_app/widget/customize.dart';
import 'package:firebase_app/widget/product_card_custome.dart';
import 'package:flutter/material.dart';
import 'package:slideable/slideable.dart';

import '../../../data/firebase_field.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  CollectionReference dataRef = FirebaseFirestore.instance
      .collection(FireBaseAPI().productCollectionName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Product'),
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
                    isSlidable: true,
                  );
                });
          }
        },
      ),
    );
  }
}
