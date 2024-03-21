import 'package:dma_card/data/network/BaseApiServices.dart';
import 'package:dma_card/data/network/NetworkApiServices.dart';
import 'package:dma_card/model/forgot_pass_verify_response.dart';
import 'package:dma_card/model/login_model.dart';
import 'package:dma_card/res/app_url.dart';

import '../model/base_response.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<LoginModel> loginApi(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return LoginModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> signUpApi(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registrationUrl, data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> sendOTPApi(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.otpUrl, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<ForgotPassVerifyResponse> forgotPassVerifyResponse(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.verifyForForgotPass, data);
      return ForgotPassVerifyResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> setPassResponse(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.resetPass, data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> changePassResponse(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.changePass,token,data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

}