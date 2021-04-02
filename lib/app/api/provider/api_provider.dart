import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_task/app/api/services/base_services.dart';
import 'package:news_task/app/data/models/news_response.dart';

// RxString USER_TOKEN = ''.obs;

class ApiProvider extends GetConnect with BaseApiServices {
  static const String _BASE_URL = 'https://newsapi.org/v2/';

  @override
  void onInit() {
    httpClient.baseUrl = _BASE_URL;
    httpClient.timeout = Duration(seconds: 5);
    httpClient.errorSafety = true;
    httpClient.addResponseModifier((request, response) {
      debugPrint(
        '\n╔══════════════════════════ Response ══════════════════════════\n'
        '╟ REQUEST ║ ${request.method.toUpperCase()}\n'
        '╟ url: ${request.url}\n'
        '╟ Headers: ${request.headers}\n'
        '╟ Body: ${request.bodyBytes?.map((event) => event.asMap().toString()) ?? ''}\n'
        '╟ Status Code: ${response.statusCode}\n'
        '╟ Data: ${response.bodyString?.toString() ?? ''}'
        '\n╚══════════════════════════ Response ══════════════════════════\n',
        wrapWidth: 1024,
      );
      return request;
    });
  }

  @override
  Future<Response> getTopHeadlines(Map<String, String> requestQuery) async {
    final response = await get('top-headlines',
        query: requestQuery, decoder: (data) => NewsResponse.fromJson(data));
    return response;
  }
}
