import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:hello_world/config/service_url.dart';

Future request({@required String url, dynamic formData}) async {
  try {
    Response response;
    // dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded') as String;
    if (formData == null) {
      response = await Dio().post(SERVICE_PATH['$url']);
    } else {
      response = await Dio().post(SERVICE_PATH['$url'], data: formData);
    }

    if (response.statusCode == 200) return response;
    throw Exception('后台接口出现异常!');
  } catch (e) {}
}

Future getHomePageContent() async {
  Response<dynamic> response =
      await Dio().post(SERVICE_PATH['HOME_PAGE_CONTENT']);

  return response;
}

Future getHomePageBelowContent() async {
  int page = 1;
  Response<dynamic> response =
      await Dio().post(SERVICE_PATH['HOME_PAGE_BELOW_CONTENT'], data: page);

  if (response.statusCode == 200) return response;
  throw Exception('后台接口出现异常!');
}

Future getCategory() async {
  Response<dynamic> response =
      await Dio().get(SERVICE_PATH['CATEGORY_PAGE_GET_CATEGORY']);

  return response;
}
