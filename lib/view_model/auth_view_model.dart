import 'package:dma_card/respository/auth_repository.dart';
import 'package:dma_card/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      Utils.flushBarErrorMessage(value.toString(), context);
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}