class LoginModel {
  bool? success;
  int? statusCode;
  String? message;
  String? token;
  Data? data;

  LoginModel(
      {this.success, this.statusCode, this.message, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? usrEmail;
  String? firstName;
  String? lastName;
  String? birthDate;
  bool? isActive;
  UserPhone? userPhone;
  UserAddress? userAddress;
  List<String>? groups;
  String? usrProfilePic;

  Data(
      {this.id,
        this.usrEmail,
        this.firstName,
        this.lastName,
        this.birthDate,
        this.isActive,
        this.userPhone,
        this.userAddress,
        this.groups,
        this.usrProfilePic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usrEmail = json['usr_email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthDate = json['birth_date'];
    isActive = json['is_active'];
    userPhone = json['user_phone'] != null
        ? new UserPhone.fromJson(json['user_phone'])
        : null;
    userAddress = json['user_address'] != null
        ? new UserAddress.fromJson(json['user_address'])
        : null;
    groups = json['groups'].cast<String>();
    usrProfilePic = json['usr_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usr_email'] = this.usrEmail;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birth_date'] = this.birthDate;
    data['is_active'] = this.isActive;
    if (this.userPhone != null) {
      data['user_phone'] = this.userPhone!.toJson();
    }
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress!.toJson();
    }
    data['groups'] = this.groups;
    data['usr_profile_pic'] = this.usrProfilePic;
    return data;
  }
}

class UserPhone {
  Null? phnBusiness;
  String? phnCell;
  Null? phnHome;

  UserPhone({this.phnBusiness, this.phnCell, this.phnHome});

  UserPhone.fromJson(Map<String, dynamic> json) {
    phnBusiness = json['phn_business'];
    phnCell = json['phn_cell'];
    phnHome = json['phn_home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phn_business'] = this.phnBusiness;
    data['phn_cell'] = this.phnCell;
    data['phn_home'] = this.phnHome;
    return data;
  }
}

class UserAddress {
  String? addressLine1;
  String? addressLine2;
  String? postCode;
  String? upazila;
  String? city;
  String? state;
  String? country;

  UserAddress(
      {this.addressLine1,
        this.addressLine2,
        this.postCode,
        this.upazila,
        this.city,
        this.state,
        this.country});

  UserAddress.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    postCode = json['post_code'];
    upazila = json['upazila'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['post_code'] = this.postCode;
    data['upazila'] = this.upazila;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}