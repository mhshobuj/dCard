import 'package:dma_card/model/rewards_list_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class RewardsRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<RewardListResponse> getRewardsList(String token)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponse(AppUrl.rewardsList, token);
      return RewardListResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}