class ForgotPassVerifyResponse {
  bool? success;
  int? statusCode;
  String? message;
  String? emailOrPhone;
  String? otp;

  ForgotPassVerifyResponse(
      {this.success,
        this.statusCode,
        this.message,
        this.emailOrPhone,
        this.otp});

  ForgotPassVerifyResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    emailOrPhone = json['email_or_phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['email_or_phone'] = this.emailOrPhone;
    data['otp'] = this.otp;
    return data;
  }
}