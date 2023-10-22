import 'package:firebase_app/data/firebase_field.dart';

class ProductModel extends FireBaseAPI {
  int? id;
  String? name;
  String? color;
  String? image;
  double? price;
  int? qty;

  ProductModel({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.color,
    this.image,
  });
  Map<String, dynamic> toMap() {
    return {
      productId: id,
      productName: name,
      productQty: qty,
      productPrice: price,
      productColor: color,
      productImage: image,
    };
  }

  ProductModel.fromQuerySnapshot(Map<String, dynamic> res)
      : id = res[FireBaseAPI().productId],
        name = res[FireBaseAPI().productName],
        qty = res[FireBaseAPI().productQty],
        price = res[FireBaseAPI().productPrice],
        color = res[FireBaseAPI().productColor],
        image = res[FireBaseAPI().productImage];
}
