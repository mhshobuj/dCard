import 'package:dma_card/utils/routes/routes_name.dart';
import 'package:dma_card/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../model/login_model.dart';

class SplashServices{

  Future<LoginModel> getUserData() => TokenViewModel().getToken();

  void checkAuthentication(BuildContext context)async{
    getUserData().then((value)async{

      if(value.token == "null" || value.token == ''){
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
      }else{
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}