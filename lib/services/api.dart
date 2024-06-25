import 'dart:convert';
import 'package:hezr/global/constants/app_tokens.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  static final Map<String, String> _header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${AppTokens.bearerToken}'
  };
  // static final Map<String, String> token = {
  //   'Authorization': AppTokens.bearerToken
  // };

  static Future<Response?> post({
    required String endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.post(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }

  static Future<Response?> postwithoutHeaderAPi({
    required String endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response =
        await http.post(Uri.parse(endPoint), body: jsonEncode(body));

    return response;
  }

  static Future<Response?> postwithOutHeader({
    required String endPoint,
    required Map<String, dynamic>? body,
    required Map<String, String>? userToken,
  }) async {
    final response = await http.post(Uri.parse(endPoint),
        headers: userToken, body: jsonEncode(body));

    return response;
  }

  static Future<Response?> put({
    required String endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.put(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }

  static Future<http.StreamedResponse> patchImage({
    required String url,
    required String filepath,
    required String userToken,
  }) async {
    // url = formater(url);
    // String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("image", filepath));
    request.headers.addAll(
        {"Content-type": "multipart/form-data", "Authorization": userToken});
    var response = request.send();
    return response;
  }

  static Future<Response?> get({
    required String endPoint,
  }) async {
    final response = await http.get(Uri.parse(endPoint), headers: _header);

    return response;
  }

  static Future<Response?> delete({
    required endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.delete(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }
}
