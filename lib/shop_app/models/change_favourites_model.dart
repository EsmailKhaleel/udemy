class ChangeFavouritesModel {
  bool? status;
  String? message;
  ChangeFavouritesModel({this.message, this.status});
  ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
