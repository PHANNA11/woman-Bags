import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/home/products/model/product_model.dart';

import '../data/firebase_field.dart';

class ProductMethod {
  final firebaseProductData = FirebaseFirestore.instance
      .collection(FireBaseAPI().productCollectionName);
  Future addProduct(ProductModel product) async {
    // CollectionReference dataRef = FirebaseFirestore.instance
    //     .collection(FireBaseAPI().productCollectionName);
    await firebaseProductData.add(product.toMap());
  }

  Future deleteProduct({required String documentId}) async {
    await firebaseProductData.doc(documentId).delete();
  }

  Future updateProduct(
      {required ProductModel product, required String documentId}) async {
    await firebaseProductData.doc(documentId).set(product.toMap());
  }
}
