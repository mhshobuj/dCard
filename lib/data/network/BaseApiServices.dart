abstract class BaseApiServices{

  Future<dynamic> getGetTokenApiResponse(String url, String token);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getGetApiResponse(String url);

}