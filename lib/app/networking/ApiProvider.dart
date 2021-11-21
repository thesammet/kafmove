import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:move/app/networking/CustomException.dart';
import 'package:move/app/services/shared_config.dart';

class ApiProvider {
  final String _baseUrl = "https://movetech.app/api";

  Future<dynamic> post(
      {@required String url, Map<String, String> bodyMap}) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, headers: {
        "Device": "123456",
        "X-Token": StorageUtil.getString("token"),
      }, body: {
        bodyMap
      });
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var tempJson = utf8.decode(response.bodyBytes);
        Map valueMapJson = json.decode(tempJson);
        print("value map json: " + tempJson.toString());
        return valueMapJson;

      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
