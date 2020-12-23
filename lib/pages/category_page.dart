import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_world/model/category.dart';
import 'package:hello_world/service/service_method.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }

  void _getCategory() async {
    request(url: 'CATEGORY_PAGE_GET_CATEGORY').then((val) {
      val = json.decode(val.toString());

      CategoryListModel list = CategoryListModel.fromJson(val);
    });
  }
}

class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
