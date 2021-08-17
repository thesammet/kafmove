import 'package:flutter/foundation.dart';
import 'package:move/app/services/APIService/api_keys.dart';

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.omakademiSandboxKey);

  static final String host = "movetech.app/api";
}
