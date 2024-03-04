class CollectionHistoryResponse {
  bool? success;
  int? statusCode;
  String? message;
  List<Data>? data;

  CollectionHistoryResponse(
      {this.success, this.statusCode, this.message, this.data});

  CollectionHistoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  ServiceDetail? serviceDetail;
  String? merchantName;
  String? merchantLogo;
  String? orderId;
  String? purpose;
  double? amount; // Change type to double
  String? created_at;

  Data({
    this.id,
    this.serviceDetail,
    this.merchantName,
    this.merchantLogo,
    this.orderId,
    this.purpose,
    this.amount,
    this.created_at,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDetail = json['service_detail'] != null
        ? ServiceDetail.fromJson(json['service_detail'])
        : null;
    merchantName = json['merchant_name'];
    merchantLogo = json['merchant_logo'];
    orderId = json['order_id'];
    purpose = json['purpose'];
    // Change the type conversion here
    amount = json['amount'] != null ? json['amount'].toDouble() : null;
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (serviceDetail != null) {
      data['service_detail'] = serviceDetail!.toJson();
    }
    data['merchant_name'] = merchantName;
    data['merchant_logo'] = merchantLogo;
    data['order_id'] = orderId;
    data['purpose'] = purpose;
    data['amount'] = amount; // No conversion needed here
    data['created_at'] = created_at;
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