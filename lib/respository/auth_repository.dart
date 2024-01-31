import 'package:dma_card/data/network/BaseApiServices.dart';
import 'package:dma_card/data/network/NetworkApiServices.dart';
import 'package:dma_card/res/app_url.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registrationUrl, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

}