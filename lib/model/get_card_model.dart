class GetCardModel {
  bool? success;
  int? statusCode;
  String? message;
  bool? hasCard;
  Data? data;

  GetCardModel(
      {this.success, this.statusCode, this.message, this.hasCard, this.data});

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
  int? id;
  String? skuNumber;
  String? cardNumber;
  String? cardName;
  String? cvc;
  String? status;
  String? provider;
  String? userName;
  String? expiresAt;
  Request? request;
  int? reward;
  String? activeImage;
  String? inactiveImage;
  bool? cardFeeStatus;

  Data(
      {this.id,
        this.skuNumber,
        this.cardNumber,
        this.cardName,
        this.cvc,
        this.status,
        this.provider,
        this.userName,
        this.expiresAt,
        this.request,
        this.reward,
        this.activeImage,
        this.inactiveImage,
        this.cardFeeStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skuNumber = json['sku_number'];
    cardNumber = json['card_number'];
    cardName = json['card_name'];
    cvc = json['cvc'];
    status = json['status'];
    provider = json['provider'];
    userName = json['user_name'];
    expiresAt = json['expires_at'];
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
    reward = json['reward'];
    activeImage = json['active_image'];
    inactiveImage = json['inactive_image'];
    cardFeeStatus = json['card_fee_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku_number'] = this.skuNumber;
    data['card_number'] = this.cardNumber;
    data['card_name'] = this.cardName;
    data['cvc'] = this.cvc;
    data['status'] = this.status;
    data['provider'] = this.provider;
    data['user_name'] = this.userName;
    data['expires_at'] = this.expiresAt;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    data['reward'] = this.reward;
    data['active_image'] = this.activeImage;
    data['inactive_image'] = this.inactiveImage;
    data['card_fee_status'] = this.cardFeeStatus;
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