class CardRequestResponse {
  bool success;
  int statusCode;
  String message;
  Data data;

  CardRequestResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CardRequestResponse.fromJson(Map<String, dynamic> json) {
    return CardRequestResponse(
      success: json['success'],
      statusCode: json['status_code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  SslResponse sslresponse;

  Data({required this.sslresponse});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sslresponse: SslResponse.fromJson(json['sslresponse']),
    );
  }
}

class SslResponse {
  String apiConnect;
  int statusCode;
  int statusSubCode;
  SslData data;
  String message;

  SslResponse({
    required this.apiConnect,
    required this.statusCode,
    required this.statusSubCode,
    required this.data,
    required this.message,
  });

  factory SslResponse.fromJson(Map<String, dynamic> json) {
    return SslResponse(
      apiConnect: json['APIConnect'],
      statusCode: json['status_code'],
      statusSubCode: json['status_sub_code'],
      data: SslData.fromJson(json['data']),
      message: json['message'] ?? "",
    );
  }
}

class SslData {
  String sessionKey;
  Transaction transaction;
  bool redirect;
  String redirectGatewayURL;
  String successUrl;
  String failUrl;
  String cancelUrl;

  SslData({
    required this.sessionKey,
    required this.transaction,
    required this.redirect,
    required this.redirectGatewayURL,
    required this.successUrl,
    required this.failUrl,
    required this.cancelUrl,
  });

  factory SslData.fromJson(Map<String, dynamic> json) {
    return SslData(
      sessionKey: json['sessionkey'],
      transaction: Transaction.fromJson(json['transaction']),
      redirect: json['redirect'],
      redirectGatewayURL: json['redirectGatewayURL'],
      successUrl: json['success_url'],
      failUrl: json['fail_url'],
      cancelUrl: json['cancel_url'],
    );
  }
}

class Transaction {
  String status;

  Transaction({required this.status});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      status: json['status'],
    );
  }
}
