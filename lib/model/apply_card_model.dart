class ApplyCardResponse {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  ApplyCardResponse({this.success, this.statusCode, this.message, this.data});

  ApplyCardResponse.fromJson(Map<String, dynamic> json) {
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
  String? paymentService;
  int? cardRequest;

  Data({this.paymentService, this.cardRequest});

  Data.fromJson(Map<String, dynamic> json) {
    paymentService = json['payment_service'];
    cardRequest = json['card_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_service'] = this.paymentService;
    data['card_request'] = this.cardRequest;
    return data;
  }
}