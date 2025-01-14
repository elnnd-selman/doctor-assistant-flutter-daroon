import 'dart:convert';
import 'dart:io';
import 'package:daroon_doctor/global/constants/app_tokens.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final Map<String, String> _header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${AppTokens.bearerToken}'
  };

  static Future<http.Response?> post({
    required String endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.post(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }

  // static Future<http.Response?> postwithoutHeaderAPi({
  //   required String endPoint,
  //   required Map<String, dynamic>? body,
  // }) async {
  //   final response =
  //       await http.post(Uri.parse(endPoint), body: jsonEncode(body));

  //   return response;
  // }

  static Future<http.Response?> postWithHeader({
    required String endPoint,
    required Map<String, dynamic>? body,
    required Map<String, String>? userToken,
  }) async {
    if (kDebugMode) {
      print(endPoint);
    }
    final response = await http.post(Uri.parse(endPoint),
        headers: userToken, body: jsonEncode(body));

    return response;
  }

  static Future<http.Response?> putWithHeader({
    required String endPoint,
    required Map<String, dynamic>? body,
    required Map<String, String>? userToken,
  }) async {
    if (kDebugMode) {
      print(endPoint);
    }
    final response = await http.put(Uri.parse(endPoint),
        headers: userToken, body: jsonEncode(body));

    return response;
  }

  static Future<http.Response?> put({
    required String endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.put(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }

  static Future<http.Response> patchImage({
    required String url,
    required String filepath,
    required String userToken,
  }) async {
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("image", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": 'Bearer $userToken'
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static Future<http.Response?> get({
    required String endPoint,
  }) async {
    final response = await http.get(Uri.parse(endPoint), headers: _header);

    return response;
  }

  static Future<http.Response?> getwithUserToken({
    required String endPoint,
    required Map<String, String>? userToken,
  }) async {
    if (kDebugMode) {
      print(endPoint);
    }
    final response = await http.get(Uri.parse(endPoint), headers: userToken);

    return response;
  }

  static Future<http.Response?> delete({
    required endPoint,
    required Map<String, dynamic>? body,
  }) async {
    final response = await http.delete(Uri.parse(endPoint),
        headers: _header, body: jsonEncode(body));

    return response;
  }

  static Future<http.Response?> deleteWithHeader({
    required endPoint,
    required Map<String, dynamic>? body,
    required Map<String, String>? userToken,
  }) async {
    final response = await http.delete(
      Uri.parse(endPoint),
      headers: userToken,
    );

    return response;
  }

  static Future<http.Response> uploadContentApi({
    required String userToken,
    required List<String> imageList,
    required List<String> videoList,
    required String titleKU,
    required String titleEN,
    required String titleAR,
    required String descriptionKU,
    required String descriptionEN,
    required String descriptionAR,
  }) async {
    var uri = Uri.parse(
      '${AppTokens.apiURl}/contents?title_ku=$titleKU&title_ar=$titleAR&title_en=$titleEN&content_ku=$descriptionKU&content_en=$descriptionEN&content_ar=$descriptionAR&isPrivate=false&contentType=post',
    );
    var request = http.MultipartRequest('POST', uri)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..headers["Authorization"] = userToken;
    if (imageList.isNotEmpty) {
      for (var image in imageList) {
        var multipartFile = await http.MultipartFile.fromPath('images', image);
        request.files.add(multipartFile);
      }
    }

    if (videoList.isNotEmpty) {
      for (var video in videoList) {
        var multipartFile = await http.MultipartFile.fromPath('videos', video);
        request.files.add(multipartFile);
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static Future<http.Response> upadteContentApi({
    required String userToken,
    required List<String> imageList,
    required String contentID,
    required List<String> videoList,
    required String titleKU,
    required String titleEN,
    required String titleAR,
    required String descriptionKU,
    required String descriptionEN,
    required String descriptionAR,
  }) async {
    var uri = Uri.parse(
      '${AppTokens.apiURl}/contents/$contentID/update?title_ku=$titleKU&title_ar=$titleAR&title_en=$titleEN&content_ku=$descriptionKU&content_en=$descriptionEN&content_ar=$descriptionAR&isPrivate=false&contentType=post',
    );
    var request = http.MultipartRequest('PUT', uri)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..headers["Authorization"] = userToken;
    if (imageList.isNotEmpty) {
      for (var image in imageList) {
        var multipartFile = await http.MultipartFile.fromPath('images', image);
        request.files.add(multipartFile);
      }
    }

    if (videoList.isNotEmpty) {
      for (var video in videoList) {
        var multipartFile = await http.MultipartFile.fromPath('videos', video);
        request.files.add(multipartFile);
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  static Future<http.Response> uploadImageInDataBase({
    required String url,
    required Map<String, String> headers,
    required String imageURL,
    required String fieldName,
  }) async {
    if (kDebugMode) {
      print(url);
    }
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(
      http.MultipartFile(
        fieldName,
        File(imageURL).readAsBytes().asStream(),
        File(imageURL).lengthSync(),
        filename: DateTime.now().toString(),
      ),
    );
    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  static Future<http.Response?> patchWithHeader({
    required String endPoint,
    required Map<String, dynamic>? body,
    required Map<String, String>? userToken,
  }) async {
    if (kDebugMode) {
      print(endPoint);
    }
    final response = await http.put(Uri.parse(endPoint),
        headers: userToken, body: jsonEncode(body));

    return response;
  }
}
