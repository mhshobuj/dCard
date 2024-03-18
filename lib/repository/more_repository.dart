import 'package:dma_card/model/user_details_response.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_url.dart';

class MoreRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<UserDetailsResponse> getUserDetails(String token)async {
    try{
      dynamic response = await _apiServices.getGetTokenApiResponse(AppUrl.userDetails, token);
      return UserDetailsResponse.fromJson(response);
    }catch(e){
      rethrow;
    }
  }
}