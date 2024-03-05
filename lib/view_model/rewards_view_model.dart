import 'package:dma_card/model/rewards_list_model.dart';
import 'package:dma_card/repository/rewards_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../utils/utils.dart';

class RewardsViewModel with ChangeNotifier{

  final _myRepo = RewardsRepository();

  Future<RewardListResponse> getRewardsList(String token, BuildContext context) async {

    try {
      final RewardListResponse rewardListResponse = await _myRepo.getRewardsList(token);

      if (kDebugMode) {
        print(rewardListResponse.toJson());
        print(rewardListResponse.message);
      }

      return rewardListResponse; // Return the cardResponse
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