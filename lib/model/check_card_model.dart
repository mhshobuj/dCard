class CheckCardResponse {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  CheckCardResponse({this.success, this.statusCode, this.message, this.data});

  CheckCardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? userPhone;
  String? cardSku;

  Data({this.userId, this.userPhone, this.cardSku});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userPhone = json['user_phone'];
    cardSku = json['card_sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_phone'] = this.userPhone;
    data['card_sku'] = this.cardSku;
    return data;
  }
}

