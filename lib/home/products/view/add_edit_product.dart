// ignore_for_file: must_be_immutable

import 'package:firebase_app/home/products/model/product_model.dart';
import 'package:firebase_app/method/firebase_method.dart';
import 'package:firebase_app/widget/customize.dart';
import 'package:firebase_app/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditProductScreen extends StatefulWidget {
  AddEditProductScreen({super.key, this.productModel, this.documentId});
  ProductModel? productModel;
  String? documentId;

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  RxString? linkController = ''.obs;
  void clear() {
    nameController.text = '';
    qtyController.text = '';
    priceController.text = '';
    colorController.text = '';
    linkController = ''.obs;
  }

  void addData() {
    nameController.text = widget.productModel!.name!;
    qtyController.text = widget.productModel!.qty!.toString();
    priceController.text = widget.productModel!.price.toString();
    colorController.text = widget.productModel!.color!;
    linkController = widget.productModel!.image.toString().obs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.productModel == null ? clear() : addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldWidget(
              hindText: 'Enter Product name',
              controller: nameController,
            ),
            TextFieldWidget(
              hindText: 'Enter Product price',
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            TextFieldWidget(
              hindText: 'Enter Product Qty',
              controller: qtyController,
              keyboardType: TextInputType.number,
            ),
            TextFieldWidget(
              hindText: 'Enter Product Color',
              controller: colorController,
            ),
            TextFieldWidget(
              hindText: 'Enter Product Link Image',
              onChanged: (p0) {
                linkController!.value = p0;
              },
              keyboardType: TextInputType.url,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Container(
                  height: 200,
                  width: 200,
                  decoration: linkController!.value.isEmpty
                      ? BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2X4CnpVnS9MXrVidbQmWwXxztMcUYQycu_BrgjwaG_ZeLRvZJsny_3pc3wvPcg1cVpMY&usqp=CAU')),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 1)
                            ])
                      : BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(linkController!.value)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 1)
                            ]),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            openLoading();
            widget.productModel == null
                ? await ProductMethod()
                    .addProduct(
                    ProductModel(
                      id: DateTime.now().microsecondsSinceEpoch,
                      name: nameController.text,
                      qty: int.parse(qtyController.text),
                      price: double.parse(priceController.text),
                      color: colorController.text,
                      image: linkController!.value,
                    ),
                  )
                    .whenComplete(() {
                    closeLoading();
                    Get.back();
                    Get.back();
                  })
                : await ProductMethod()
                    .updateProduct(
                        product: ProductModel(
                            id: widget.productModel!.id,
                            name: nameController.text,
                            qty: int.parse(qtyController.text),
                            price: double.parse(priceController.text),
                            color: colorController.text,
                            image: linkController!.value),
                        documentId: widget.documentId!)
                    .whenComplete(() {
                    closeLoading();
                    Get.back();
                    Get.back();
                  });
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            child: const Center(
                child: Text(
              'save',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
