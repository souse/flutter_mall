import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_world/service/service_method.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  bool searched = false;
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
    request(url: 'HOME_PAGE_BELOW_CONTENT', formData: {'page': page})
        .then((val) {
      val = json.decode(val.toString());
      List<Map> newList = (val['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newList);
        page++;
        searched = true;
      });
    });
  }

  Widget _hotTitle = Container(
    width: ScreenUtil().setWidth(375),
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 5.0),
          padding: EdgeInsets.only(left: 3.0, right: 3.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '火',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Text('火爆专区')
      ],
    ),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<InkWell> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(375),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: ScreenUtil().setSp(26),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('¥${val['mallPrice']}'),
                    Text(
                      '¥${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return searched ? Text('火爆专区数据为空') : Text('加载中...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}
