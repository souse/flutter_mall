import 'package:dio/dio.dart';
import 'dart:async';

import 'package:hello_world/config/service_url.dart';

Future getHomePageContent() async {
  Response<dynamic> response =
      await Dio().post(SERVICE_PATH['HOME_PAGE_CONTENT']);

  return response;
}
