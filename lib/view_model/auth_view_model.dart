
import 'package:dma_card/model/base_response.dart';
import 'package:dma_card/model/forgot_pass_verify_response.dart';
import 'package:dma_card/model/login_model.dart';
import 'package:dma_card/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../repository/auth_repository.dart';
import 'login_view_model.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  final TokenViewModel _loginViewModel = TokenViewModel();

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;
  setLoginLoading(bool value){
    _loginLoading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  bool _otpSendLoading = false;
  bool get otpSendLoading => _otpSendLoading;
  setOTPSendLoading(bool value){
    _otpSendLoading = value;
    notifyListeners();
  }

  Future<LoginModel> loginApi(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    try {
      final LoginModel loginResponse = await _myRepo.loginApi(data);

      _loginViewModel.saveUser(loginResponse);

      setLoginLoading(false);
      return loginResponse;
      /*Utils.flushBarErrorMessage("LogIn Successfully", context);
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);*/
      if (kDebugMode) {
        print(loginResponse.toJson());
      }
    } catch (error) {
      setLoginLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<BaseResponse> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    /*_myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      //Utils.toastMessage("SignUp Successfully");
      //Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });*/

    try {
      final BaseResponse signUpResponse = await _myRepo.signUpApi(data);
      setSignUpLoading(false);
      if (kDebugMode) {
        print(signUpResponse.message);
        print(signUpResponse.toJson());
      }

      return signUpResponse; // Return the cardResponse
    } catch (error) {
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<void> sendOTPApi(dynamic data, BuildContext context) async {
    setOTPSendLoading(true);
    _myRepo.sendOTPApi(data).then((value){
      setOTPSendLoading(false);
      Utils.toastMessage("OTP send Successfully");
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setOTPSendLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<ForgotPassVerifyResponse> forgetPassVerify(dynamic data, BuildContext context) async {
    try {
      final ForgotPassVerifyResponse forgotPassVerifyResponse = await _myRepo.forgotPassVerifyResponse(data);
      return forgotPassVerifyResponse;
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<BaseResponse> resetPass(dynamic data, BuildContext context) async {
    try {
      final BaseResponse resetPassResponse = await _myRepo.setPassResponse(data);
      return resetPassResponse;
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<BaseResponse> changePass(String token, dynamic data, BuildContext context) async {
    try {
      final BaseResponse changePassResponse = await _myRepo.changePassResponse(token, data);
      return changePassResponse;
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }
}