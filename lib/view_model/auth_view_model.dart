import 'package:dma_card/respository/auth_repository.dart';
import 'package:dma_card/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/routes/routes_name.dart';
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

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    try {
      final loginResponse = await _myRepo.loginApi(data);

      _loginViewModel.saveUser(loginResponse);

      setLoginLoading(false);
      Utils.flushBarErrorMessage("LogIn Successfully", context);
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.home, (route) => false);
      if (kDebugMode) {
        print(loginResponse.toJson());
      }
    } catch (error) {
      setLoginLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    }
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      Utils.toastMessage("SignUp Successfully");
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
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
}