import 'package:crafty_bay/data/models/product_model.dart';

class ProductListModel {
  String? msg;
  List<Product>? ProductList;

  ProductListModel({this.msg, this.ProductList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      ProductList = <Product>[];
      json['data'].forEach((v) {
        ProductList!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.ProductList != null) {
      data['data'] = this.ProductList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
