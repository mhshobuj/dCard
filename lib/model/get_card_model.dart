class GetCardModel {
  bool? success;
  int? statusCode;
  String? message;
  bool? hasCard;
  Null? data;

  GetCardModel(
      {this.success, this.statusCode, this.message, this.hasCard, this.data});

  GetCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    hasCard = json['has_card'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['has_card'] = this.hasCard;
    data['data'] = this.data;
    return data;
  }
}