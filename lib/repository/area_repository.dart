import 'package:dma_card/model/base_response.dart';
import 'package:dma_card/model/get_area_list.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/apply_card_model.dart';
import '../model/online_fee_with_apply_response.dart';
import '../res/app_url.dart';

class AreaRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<GetAreaList> getAreaList()async {
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.getAreaUrl);
      return GetAreaList.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> updateAddress(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.updateAddress, token, data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<ApplyCardResponse> applyCard(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.applyCard, token, data);
      return ApplyCardResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CardRequestResponse> applyCardOnlineFee(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.applyCardOnlinePay, token, data);
      return CardRequestResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}