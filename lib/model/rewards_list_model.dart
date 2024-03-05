class RewardListResponse {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  RewardListResponse({this.success, this.statusCode, this.message, this.data});

  RewardListResponse.fromJson(Map<String, dynamic> json) {
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
  int? rewardPoints;
  String? lastRedeemDate;
  List<Redeems>? redeems;

  Data({this.rewardPoints, this.lastRedeemDate, this.redeems});

  Data.fromJson(Map<String, dynamic> json) {
    rewardPoints = json['reward_points'];
    lastRedeemDate = json['last_redeem_date'];
    if (json['redeems'] != null) {
      redeems = <Redeems>[];
      json['redeems'].forEach((v) {
        redeems!.add(new Redeems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reward_points'] = this.rewardPoints;
    data['last_redeem_date'] = this.lastRedeemDate;
    if (this.redeems != null) {
      data['redeems'] = this.redeems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Redeems {
  int? id;
  ServiceDetail? serviceDetail;
  String? merchantName;
  String? merchantLogo;
  String? orderId;
  String? purpose;
  double? amount;
  String? createdAt;

  Redeems(
      {this.id,
        this.serviceDetail,
        this.merchantName,
        this.merchantLogo,
        this.orderId,
        this.purpose,
        this.amount,
        this.createdAt});

  Redeems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDetail = json['service_detail'] != null
        ? new ServiceDetail.fromJson(json['service_detail'])
        : null;
    merchantName = json['merchant_name'];
    merchantLogo = json['merchant_logo'];
    orderId = json['order_id'];
    purpose = json['purpose'];
    amount = json['amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.serviceDetail != null) {
      data['service_detail'] = this.serviceDetail!.toJson();
    }
    data['merchant_name'] = this.merchantName;
    data['merchant_logo'] = this.merchantLogo;
    data['order_id'] = this.orderId;
    data['purpose'] = this.purpose;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ServiceDetail {
  String? type;
  String? cardSku;
  int? usedPoint;
  int? merchantId;
  int? earnedPoints;
  int? shopBranchId;
  int? availablePoints;
  int? shopBranchDevice;

  ServiceDetail(
      {this.type,
        this.cardSku,
        this.usedPoint,
        this.merchantId,
        this.earnedPoints,
        this.shopBranchId,
        this.availablePoints,
        this.shopBranchDevice});

  ServiceDetail.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    cardSku = json['card_sku'];
    usedPoint = json['used_point'];
    merchantId = json['merchant_id'];
    earnedPoints = json['earned_points'];
    shopBranchId = json['shop_branch_id'];
    availablePoints = json['available_points'];
    shopBranchDevice = json['shop_branch_device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['card_sku'] = this.cardSku;
    data['used_point'] = this.usedPoint;
    data['merchant_id'] = this.merchantId;
    data['earned_points'] = this.earnedPoints;
    data['shop_branch_id'] = this.shopBranchId;
    data['available_points'] = this.availablePoints;
    data['shop_branch_device'] = this.shopBranchDevice;
    return data;
  }
}