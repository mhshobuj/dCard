import 'package:dma_card/model/get_area_list.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
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
}