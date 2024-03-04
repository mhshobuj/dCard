abstract class BaseApiServices{

  Future<dynamic> getGetTokenApiResponse(String url, String token);
  Future<dynamic> getGetTokenApiResponseWithPath(String url, String token, String path);
  Future<dynamic> getGetTokenApiResponseWithQuery(String url, String token, String query);
  Future<dynamic> getGetTokenApiResponseWithMultipleQuery(String url, String token, String query1,String query2);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostTokenApiResponse(String url, String token, dynamic data);
  Future<dynamic> getGetApiResponse(String url);

}