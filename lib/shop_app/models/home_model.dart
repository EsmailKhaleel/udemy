// class HomeModel {
//   bool? status;
//   HomeDataModel? data;

//   HomeModel({
//     required this.status,
//     required this.data,
//   });

//   HomeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = HomeDataModel.fromJson(json['data']);
//   }
// }

// class HomeDataModel {
//   List<BannersModel>? banners=[];
//   List<ProductsModel>? products;

//   HomeDataModel({
//     required this.banners,
//     required this.products,
//   });

//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element) {
//       banners?.add(element);
//     });

//     json['products'].forEach((element) {
//       products?.add(element);
//     });
//   }
// }

// class BannersModel{
//   late int id;
//   late String image;

//   BannersModel({
//     required this.id,
//     required this.image,
//   });
//   BannersModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//   }
// }

// class ProductsModel {
//   late int id;
//   late dynamic price;
//   late dynamic oldPrice;
//   late dynamic discount;
//   late String image;
//   late String name;
//   late bool inFavourites;
//   late bool inCart;

//   ProductsModel({
//     required this.id,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.image,
//     required this.name,
//     required this.inFavourites,
//     required this.inCart,
//   });
//   ProductsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     inFavourites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
// }
class HomeModel {
  bool? status;
  Data? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
   
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Banners>? banners;
  List<Products>? products;
  String? ad;

  Data({this.banners, this.products, this.ad});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    ad = json['ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['ad'] = this.ad;
    return data;
  }
}

class Banners {
  int? id;
  String? image;
  Null? category;
  Null? product;

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['category'] = this.category;
    data['product'] = this.product;
    return data;
  }
}

class Products {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  Products(this.id,
      { 
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description,
      this.inFavorites,
      this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }
}

