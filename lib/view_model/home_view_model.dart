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

      print(cardResponse.message);

      setCardLoading(false);
      if (kDebugMode) {
        print(cardResponse.toJson());
      }

      return cardResponse; // Return the cardResponse
    } catch (error) {
      setCardLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
      // Handle the error and return null or throw it again
      throw error;
    }
  }
}