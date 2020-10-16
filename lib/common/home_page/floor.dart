import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Floor extends StatelessWidget {
  final String picAddress;
  final List<Map> floor;
  const Floor({
    Key key,
    @required this.picAddress,
    @required this.floor,
  }) : super(key: key);

  Widget _floorTitle() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(picAddress),
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: [
        _goodsItem(floor[0]),
        Column(
          children: [
            _goodsItem(floor[1]),
            _goodsItem(floor[2]),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: [
        _goodsItem(floor[3]),
        _goodsItem(floor[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _floorTitle(),
          _firstRow(),
          _otherGoods(),
        ],
      ),
    );
  }
}
