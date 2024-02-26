import 'package:dma_card/model/get_card_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<GetCardModel> getCardInfo(String token)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponse(AppUrl.getCardUrl, token);
      return GetCardModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}