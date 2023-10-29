import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/home/products/model/product_model.dart';

import '../data/firebase_field.dart';

class ProductMethod {
  final firebaseProductData = FirebaseFirestore.instance
      .collection(FireBaseAPI().productCollectionName);
  CollectionReference dataRef = FirebaseFirestore.instance
      .collection(FireBaseAPI().productCollectionName);
  Future addProduct(ProductModel product) async {
    await firebaseProductData.add(product.toMap());
  }

  Future deleteProduct({required String documentId}) async {
    await firebaseProductData.doc(documentId).delete();
  }

  Future updateProduct(
      {required ProductModel product, required String documentId}) async {
    await firebaseProductData.doc(documentId).set(product.toMap());
  }

  Stream<QuerySnapshot<Object?>> filterProduct(String? text) {
    return dataRef
        .where(FireBaseAPI().productName, isGreaterThanOrEqualTo: text)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> filterProductMaxToMin(
      double? minPrice, double? maxPrice, bool? descending) {
    return dataRef
        .where(FireBaseAPI().productPrice, isLessThanOrEqualTo: maxPrice)
        .orderBy(FireBaseAPI().productPrice, descending: descending ?? false)
        .snapshots();
  }

  Stream<QuerySnapshot<Object?>> filterProductByPriceAndSearchs(
      String? search, double? maxPrice) {
    return dataRef
        .where(FireBaseAPI().productName, isGreaterThan: search)
        .where(FireBaseAPI().productPrice, isLessThanOrEqualTo: maxPrice)
        .snapshots();
  }
}
