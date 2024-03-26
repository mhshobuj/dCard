import 'package:dma_card/model/base_response.dart';
import 'package:dma_card/model/check_card_model.dart';
import 'package:dma_card/model/collection_history_response.dart';
import 'package:dma_card/model/get_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../repository/home_repository.dart';
import '../utils/utils.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  bool _getCardLoading = false;
  bool get getCardLoading => _getCardLoading;

  setCardLoading(bool value) {
    _getCardLoading = value;
    notifyListeners();
  }

  Future<GetCardModel> getCardInfo(String token, BuildContext context) async {
    setCardLoading(true);
    try {
      final GetCardModel cardResponse = await _myRepo.getCardInfo(token);

      setCardLoading(false);
      if (kDebugMode) {
        print(cardResponse.toJson());
        print(cardResponse.message);
      }

      return cardResponse; // Return the cardResponse
    } catch (error) {
      setCardLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<CheckCardResponse> checkCard(String token, String query, BuildContext context) async {
    try {
      final CheckCardResponse checkCardResponse = await _myRepo.checkCard(token, query);

      if (kDebugMode) {
        print(checkCardResponse.message);
      }

      return checkCardResponse; // Return the cardResponse
    } catch (error) {
      Utils.flushBarErrorMessage(extractErrorMessage(error.toString()), context);
      if (kDebugMode) {
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  String extractErrorMessage(String errorString) {
    // Find the start and end index of the "status_code" value
    int statusCodeIndex = errorString.indexOf('"status_code":') + '"status_code":'.length;
    int statusCodeEndIndex = errorString.indexOf(',', statusCodeIndex);
    // Extract the status code substring
    int statusCode = int.parse(errorString.substring(statusCodeIndex, statusCodeEndIndex));

    // Map status code to error message
    String errorMessage;
    switch (statusCode) {
      case 500:
        errorMessage = "Invalid card number";
        break;
      case 404:
        errorMessage = "Wrong credentials";
        break;
      case 400:
        errorMessage = "User does not exists";
        break;
      default:
        errorMessage = "Something wrong! Try again.";
        break;
    }
    return errorMessage;
  }

  Future<CollectionHistoryResponse> collectionHistory(String token, String query1, String query2, BuildContext context) async {
    try {
      final CollectionHistoryResponse collectionHistoryResponse = await _myRepo.collectionHistory(token, query1,query2);

      if (kDebugMode) {
        print(collectionHistoryResponse.toJson());
        print(collectionHistoryResponse.message);
      }

      return collectionHistoryResponse; // Return the cardResponse
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage("${error}collection", context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<BaseResponse> getActiveOtp(String token, String path, BuildContext context) async {
    try {
      final BaseResponse getActiveOtpResponse = await _myRepo.getActiveOtp(token, path);

      if (kDebugMode) {
        print(getActiveOtpResponse.toJson());
        print(getActiveOtpResponse.message);
      }

      return getActiveOtpResponse; // Return the cardResponse
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }

  Future<BaseResponse> activeCard(BuildContext context, String token, dynamic data) async {
    try {
      final BaseResponse activeCardResponse = await _myRepo.cardActive(token, data);

      if (kDebugMode) {
        print(activeCardResponse.message);
        print(activeCardResponse.toJson());
      }

      return activeCardResponse; // Return the cardResponse
    } catch (error) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      rethrow;
    }
  }
}