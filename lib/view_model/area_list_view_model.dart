import 'package:dma_card/model/get_area_list.dart';
import 'package:dma_card/respository/area_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

class AreaViewModel with ChangeNotifier{
  final _myRepo = AreaRepository();

  bool _getAreaLoading = false;
  bool get getAreaLoading => _getAreaLoading;

  setAreaLoading(bool value) {
    _getAreaLoading = value;
    notifyListeners();
  }

  Future<GetAreaList> getAreaList(BuildContext context) async {
    setAreaLoading(true);
    try {
      final GetAreaList areaResponse = await _myRepo.getAreaList();

      print(areaResponse.message);

      setAreaLoading(false);
      if (kDebugMode) {
        print(areaResponse.toJson());
      }

      return areaResponse; // Return the cardResponse
    } catch (error) {
      setAreaLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }
}