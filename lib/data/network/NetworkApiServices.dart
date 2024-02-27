import 'dart:convert';
import 'dart:io';
import 'package:dma_card/data/app_exceptions.dart';
import 'package:dma_card/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetTokenApiResponse(String url, String token) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'}).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future<dynamic> getGetTokenApiResponseWithPath(String url, String token, String path) async {
    dynamic responseJson;

    try {
      // Construct the URL with the provided path
      final uri = Uri.parse('$url/$path');
      final response = await http.get(uri, headers: {'Authorization': 'Bearer $token'}).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }


  @override
  Future<dynamic> getGetTokenApiResponseWithQuery(String url, String token, String query) async {
    dynamic responseJson;

    try {
      // Construct the URL with query parameters
      final uri = Uri.parse(url).replace(queryParameters: {'card_number': query});
      final response = await http.get(uri, headers: {'Authorization': 'Bearer $token'}).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future getPostTokenApiResponse(String url, String token, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(Uri.parse(url), headers: {'Authorization': 'Bearer $token'}, body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
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
