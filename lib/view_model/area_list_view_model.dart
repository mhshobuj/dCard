import 'package:dma_card/model/apply_card_model.dart';
import 'package:dma_card/model/base_response.dart';
import 'package:dma_card/model/get_area_list.dart';
import 'package:dma_card/model/online_fee_with_apply_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../repository/area_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AreaViewModel with ChangeNotifier {
  final _myRepo = AreaRepository();

  bool _getUpdateLoading = false;

  bool get getUpdateLoading => _getUpdateLoading;

  setUpdateLoading(bool value) {
    _getUpdateLoading = value;
    notifyListeners();
  }

  Future<GetAreaList> getAreaList(BuildContext context) async {
    try {
      final GetAreaList areaResponse = await _myRepo.getAreaList();

      print(areaResponse.message);

      if (kDebugMode) {
        print(areaResponse.toJson());
      }

      return areaResponse; // Return the cardResponse
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }

  Future<BaseResponse> updateAddress(BuildContext context, String token, dynamic data) async {
    setUpdateLoading(true);
    try {
      final BaseResponse updateResponse =
          await _myRepo.updateAddress(token, data);

      print(updateResponse.message);
      //setUpdateLoading(false);
      if (kDebugMode) {
        print(updateResponse.toJson());
      }

      return updateResponse; // Return the cardResponse
    } catch (error) {
      setUpdateLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }

  Future<ApplyCardResponse> applyCard(BuildContext context, String token, dynamic data) async {
    setUpdateLoading(true);
    try {
      final ApplyCardResponse applyCardResponse = await _myRepo.applyCard(token, data);
      setUpdateLoading(false);

      if (kDebugMode) {
        print(applyCardResponse.toJson());
      }

      return applyCardResponse; // Return the cardResponse
    } catch (error) {
      setUpdateLoading(false);
      if (kDebugMode) {
        //Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }

  Future<CardRequestResponse> applyCardOnlineFee(BuildContext context, String token, dynamic data) async {
    setUpdateLoading(true);
    try {
      final CardRequestResponse cardRequestResponseOnlineFee = await _myRepo.applyCardOnlineFee(token, data);
      setUpdateLoading(false);

      return cardRequestResponseOnlineFee; // Return the cardResponse
    } catch (error) {
      setUpdateLoading(false);
      if (kDebugMode) {
        //Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }

  Future<CardRequestResponse> againOnlineFee(BuildContext context, String token) async {
    setUpdateLoading(true);
    try {
      final CardRequestResponse cardRequestResponseOnlineFee = await _myRepo.againOnlineFee(token);
      setUpdateLoading(false);

      return cardRequestResponseOnlineFee; // Return the cardResponse
    } catch (error) {
      setUpdateLoading(false);
      if (kDebugMode) {
        //Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }
}
