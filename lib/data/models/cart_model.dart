

import 'package:crafty_bay/data/models/product_model.dart';

class CartModel {
  String? msg;
  List<CartItem>? cartList;

  CartModel({this.msg, this.cartList});

  CartModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartList = <CartItem>[];
      json['data'].forEach((v) {
        cartList!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.cartList != null) {
      data['data'] = this.cartList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int? id;
  int? userId;
  int? productId;
  String? color;
  String? size;
  int qty=1;
  String? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CartItem(
      {this.id,
        this.userId,
        this.productId,
        this.color,
        this.size,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    qty = int.tryParse(json['qty'])??1;
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['color'] = this.color;
    data['size'] = this.size;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

