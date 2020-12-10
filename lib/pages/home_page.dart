import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hello_world/common/home_page/floor.dart';
import 'package:hello_world/common/home_page/hot_goods.dart';
import 'package:hello_world/common/home_page/recommend.dart';
import 'package:hello_world/common/home_page/swiper_diy.dart';
import 'package:hello_world/common/home_page/top_navigator.dart';
import 'package:hello_world/service/service_method.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取...';
  List<Map> hotGoodsList = [];
  int page = 1;
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: request(url: 'HOME_PAGE_CONTENT'),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());

            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navs = (data['data']['category'] as List).cast();
            String adpic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            Map shopInfo = data['data']['shopInfo'];
            List<Map> recommend = (data['data']['recommend'] as List).cast();

            return EasyRefresh(
              controller: _controller,
              child: Column(
                children: <Widget>[
                  SwiperDiy(
                    list: swiper,
                  ),
                  TopNavigator(
                    navs: navs,
                  ),
                  Image.network(adpic),
                  InkWell(
                    onTap: () => _launchUrl(17610061388),
                    child: Image.network(shopInfo['leaderImage']),
                  ),
                  Recommend(
                    recommendList: recommend,
                  ),
                  Column(
                    children: _floors(data['data']),
                  ),
                  HotGoods(hotGoodsList: hotGoodsList),
                ],
              ),
              onLoad: () async {
                await request(
                    url: 'HOME_PAGE_BELOW_CONTENT',
                    formData: {'page': page}).then((val) {
                  val = json.decode(val.toString());
                  List<Map> newList = (val['data'] as List).cast();
                  setState(() {
                    hotGoodsList.addAll(newList);
                    page++;
                  });
                });
                _controller.finishLoad(noMore: page >= 2);
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  void _launchUrl(_url) async {
    String url = 'tel:$_url';
    print(_url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Widget> _floors(Map data) {
    List<Floor> floors = [];

    for (var i = 0; i < 3; i++) {
      var index = i + 1;

      floors.add(
        Floor(
          picAddress: data['floor${index}Pic']['PICTURE_ADDRESS'],
          floor: (data['floor$index'] as List).cast(),
        ),
      );
    }
    return floors;
  }

  @override
  bool get wantKeepAlive => true;
}
