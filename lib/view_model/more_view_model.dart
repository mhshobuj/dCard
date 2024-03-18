import 'package:dma_card/model/user_details_response.dart';
import 'package:dma_card/repository/more_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

class MoreViewModel with ChangeNotifier{
  final _myRepo = MoreRepository();

  Future<UserDetailsResponse> getUserDetails(String token, BuildContext context) async {
    try {
      final UserDetailsResponse getUserDetailsResponse = await _myRepo.getUserDetails(token);

      if (kDebugMode) {
        print(getUserDetailsResponse.toJson());
        print(getUserDetailsResponse.message);
      }

      return getUserDetailsResponse; // Return the cardResponse
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