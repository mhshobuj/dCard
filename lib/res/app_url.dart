class AppUrl {

  static var baseUrl = 'https://sandbox.dma-bd.com/crimsoncup/cms/';

  static var loginUrl = '${baseUrl}auth/login/';
  static var registrationUrl = '${baseUrl}auth/registration/';
  static var otpUrl = '${baseUrl}auth/user/otp/send/';
  static var getCardUrl = '${baseUrl}nfccards/user/card/';
  static var getAreaUrl = '${baseUrl}upazilas/65/';
  static var updateAddress = '${baseUrl}auth/user/address/';
  static var applyCard = '${baseUrl}org/card/apply/';
  static var checkCard = '${baseUrl}auth/user/check-card/';
  static var getActiveOtp = '${baseUrl}nfccards/activate/scan';
  static var cardActive = '${baseUrl}nfccards/activate/otp/';
  static var collectionHistory = '${baseUrl}paymentservice/user/transactions/list';
  static var rewardsList = '${baseUrl}nfccards/card/redeem/list/';

}