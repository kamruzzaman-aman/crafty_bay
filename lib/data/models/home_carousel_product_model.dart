class HomeCarouselProductModel {
  String? msg;
  List<HomeCarouselProduct>? homeCarouselProductList;

  HomeCarouselProductModel({this.msg, this.homeCarouselProductList});

  HomeCarouselProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      homeCarouselProductList = <HomeCarouselProduct>[];
      json['data'].forEach((v) {
        homeCarouselProductList!.add(new HomeCarouselProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.homeCarouselProductList != null) {
      data['data'] = this.homeCarouselProductList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeCarouselProduct {
  int? id;
  String? title;
  String? shortDes;
  String? image;
  int? productId;
  String? createdAt;
  String? updatedAt;

  HomeCarouselProduct(
      {this.id,
        this.title,
        this.shortDes,
        this.image,
        this.productId,
        this.createdAt,
        this.updatedAt});

  HomeCarouselProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDes = json['short_des'];
    image = json['image'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_des'] = this.shortDes;
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}