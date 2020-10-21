import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/service/service_method.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    request(url: 'HOME_PAGE_BELOW_CONTENT', formData: {'page': 1}).then((val) {
      val = json.decode(val.toString());
      print(val['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('11'),
    );
  }
}
