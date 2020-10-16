import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperDiy extends StatelessWidget {
  final List list;
  const SwiperDiy({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemBuilder: (_, int index) {
          return Image.network(
            '${list[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        itemCount: list.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
