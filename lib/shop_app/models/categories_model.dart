class CategoroiesModel {
  bool? status;
  CategoriesDataModel? data;
  CategoroiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}


class CategoriesDataModel {
  int? currentPage;
  List<DataModel>? data;
    CategoriesDataModel({this.currentPage, this.data,});


  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((element) {
        data!.add(DataModel.fromJson(element));
      });
    }
      Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    return data;
  }
  }
}


class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel({this.id, this.name, this.image});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;

    return data;
  }
}
