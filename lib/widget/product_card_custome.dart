import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app/home/products/view/add_edit_product.dart';
import 'package:firebase_app/widget/customize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:slideable/slideable.dart';

import '../home/products/model/product_model.dart';
import '../method/firebase_method.dart';

// ignore: must_be_immutable
class ProductCardCustome extends StatelessWidget {
  ProductCardCustome(
      {super.key,
      required this.product,
      required this.docId,
      required this.isSlidable});
  ProductModel? product;
  String? docId;
  late bool isSlidable;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slideable(
          items: !isSlidable
              ? []
              : [
                  ActionItems(
                    icon: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Colors.red,
                    ),
                    onPress: () async {
                      openLoading();
                      await ProductMethod()
                          .deleteProduct(documentId: docId!)
                          .whenComplete(() => closeLoading());
                    },
                    backgroudColor: Colors.transparent,
                  ),
                  ActionItems(
                    icon: const Icon(
                      Icons.edit_note,
                      size: 40,
                      color: Colors.blue,
                    ),
                    onPress: () async {
                      Get.to(() => AddEditProductScreen(
                            productModel: product,
                            documentId: docId,
                          ));
                    },
                    backgroudColor: Colors.transparent,
                  ),
                ],
          backgroundColor: Colors.white24,
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
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: product!.image.toString(),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(product!.name.toString()),
                      Text(
                        "\$ ${product!.price}",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Spacer(),
                      Text('Color: ${product!.color}')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
