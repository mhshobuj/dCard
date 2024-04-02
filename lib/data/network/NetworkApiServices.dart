import 'dart:convert';
import 'package:dma_card/data/app_exceptions.dart';
import 'package:dma_card/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


class NetworkApiServices extends BaseApiServices {

  @override
  Future getGetTokenApiResponse(String url, String token) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future<dynamic> getGetTokenApiResponseWithPath(
      String url, String token, String path) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(
        '$url/$path',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future<dynamic> getGetTokenApiResponseWithQuery(
      String url, String token, String query) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(
        url,
        queryParameters: {'card_number': query},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future<dynamic> getGetTokenApiResponseWithMultipleQuery(
      String url, String token, String query1, String query2) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(
        url,
        queryParameters: {
          'start_date': query1,
          'end_date': query2,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future getGetApiResponse(String url) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.get(url);

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.post(url,data: data);

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future<dynamic> getPostTokenApiResponse(String url, String token, dynamic data) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  @override
  Future<dynamic> getPostTokenNoBodyApiResponse(String url, String token) async {
    try {
      final dio = Dio(); // Create a Dio instance
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // Handle error based on response status code
        throw response.statusCode.toString();
      }
    } on DioError catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw "No Internet Connection";
      } else if (e.type == DioErrorType.response) {
        // Handle error response from server
        throw e.response?.data['message'];
      } else {
        // Handle other Dio errors
        throw e.message;
      }
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error accrued while communication with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
