import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_world/common/home_page/floor.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());

            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navs = (data['data']['category'] as List).cast();
            String adpic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            Map shopInfo = data['data']['shopInfo'];
            List<Map> recommend = (data['data']['recommend'] as List).cast();

            return SingleChildScrollView(
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
                ],
              ),
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
