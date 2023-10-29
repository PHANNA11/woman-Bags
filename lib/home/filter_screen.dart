import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/enum/sort_type_enum.dart';
import 'package:firebase_app/home/products/model/product_model.dart';
import 'package:firebase_app/method/firebase_method.dart';
import 'package:firebase_app/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../data/firebase_field.dart';
import '../widget/product_card_custome.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';
  double maxPrice = 0.0;
  late RxBool selectSort = false.obs;
  late final maxPriceController = TextEditingController();
  List<Map<String, dynamic>>? listSortPrice = [
    {
      'label': EnumOrderByPrice.maxToMin.apiDisplay,
      'value': EnumOrderByPrice.maxToMin.apiValue
    },
    {
      'label': EnumOrderByPrice.minToMax.apiDisplay,
      'value': EnumOrderByPrice.minToMax.apiValue
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Max Price',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            TextFieldWidget(
              controller: maxPriceController,
              hindText: 'Max Price',
              onChanged: (p0) {
                setState(() {
                  maxPrice = double.parse(p0);
                });
              },
            ),
            Flexible(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listSortPrice!.length,
                itemBuilder: (context, index) => Card(
                  elevation: 0,
                  color: listSortPrice![index]['value'] == selectSort.value
                      ? const Color.fromARGB(255, 243, 214, 212)
                      : null,
                  child: ListTile(
                    onTap: () async {
                      setState(() {
                        selectSort.value = listSortPrice![index]['value'];
                      });
                    },
                    title: Text(listSortPrice![index]['label']),
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        )),
      ),
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextFieldWidget(
          onChanged: (value) {
            setState(() {
              search = value;
              maxPrice = 0.0;
            });
          },
          height: 50,
          hindText: 'Search product',
          sufficIconData: Icons.search,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: maxPrice != 0.0
            ?
            //   ProductMethod().filterProductByPriceAndSearchs(search, maxPrice),
            ProductMethod().filterProductMaxToMin(0, maxPrice, selectSort.value)
            : ProductMethod().filterProduct(search),
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
