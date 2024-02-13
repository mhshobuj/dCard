import 'package:dma_card/model/login_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier{

  Future<bool> saveUser(LoginModel model)async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("TOKEN", model.token.toString());
    notifyListeners();
    return true;
  }

  Future<LoginModel> getUser()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString("TOKEN");
    return LoginModel(
      token: token.toString()
    );
  }

  Future<bool> remove()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("TOKEN");
    return true;
  }
}