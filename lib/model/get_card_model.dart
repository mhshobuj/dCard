class GetCardModel {
  bool? success;
  int? statusCode;
  String? message;
  bool? hasCard;
  Data? data;

  GetCardModel({this.success, this.statusCode, this.message, this.hasCard, this.data});

  GetCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    hasCard = json['has_card'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['has_card'] = this.hasCard;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? cardNumber;
  String? status;
  String? provider;
  String? userName;
  String? expiresAt;
  String? activeImage;
  String? inactiveImage;
  Request? request;
  int? reward;

  Data(
      {this.cardNumber,
        this.status,
        this.provider,
        this.userName,
        this.expiresAt,
        this.activeImage,
        this.inactiveImage,
        this.request,
        this.reward});

  Data.fromJson(Map<String, dynamic> json) {
    cardNumber = json['card_number'];
    status = json['status'];
    provider = json['provider'];
    userName = json['user_name'];
    expiresAt = json['expires_at'];
    activeImage = json['active_image'];
    inactiveImage = json['inactive_image'];
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
    reward = json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_number'] = this.cardNumber;
    data['status'] = this.status;
    data['provider'] = this.provider;
    data['user_name'] = this.userName;
    data['expires_at'] = this.expiresAt;
    data['active_image'] = this.activeImage;
    data['inactive_image'] = this.inactiveImage;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    data['reward'] = this.reward;
    return data;
  }
}

class Request {
  String? status;

  Request({this.status});

  Request.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}