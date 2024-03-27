import 'package:dma_card/model/base_response.dart';
import 'package:dma_card/model/check_card_model.dart';
import 'package:dma_card/model/collection_history_response.dart';
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

  Future<CheckCardResponse> checkCard(String token, String query)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponseWithQuery(AppUrl.checkCard, token, query);
      return CheckCardResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CollectionHistoryResponse> collectionHistory(String token, String query1, String query2)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponseWithMultipleQuery(AppUrl.collectionHistory, token, query1, query2);
      return CollectionHistoryResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> getActiveOtp(String token, String path)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponseWithPath(AppUrl.getActiveOtp, token, path);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> cardActive(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.cardActive, token, data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> cardInactive(String token)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponse(AppUrl.cardInactive, token);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<BaseResponse> cardEnable(String token, dynamic data)async {
    try{
      dynamic response = await _apiServices.getPostTokenApiResponse(AppUrl.cardEnable, token, data);
      return BaseResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}