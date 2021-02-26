
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuezhan_app/utils/sliding_around_route.dart';

class RouteUtils{

  /// 跳转页面
  static void pushPage(BuildContext context,Widget page){
    if(page == null){
      return;
    }
    Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => page));
    // Navigator.of(context).push(SlidingAroundRoute(page));
  }

  ///替换跳转页面
  static void pushRePage(BuildContext context,Widget page){
    if(page == null){
      return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => page));
  }

  ///回到首页关闭其他页面
  static void pushHomePage(BuildContext context,Widget page){
    if(page == null){
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      //跳转
        new MaterialPageRoute(builder: (context) => page),
        //清除其他路由
            (route) => route == null
    );
  }

  ///关闭当前显示的页面
  static void popPage(BuildContext context,){
    Navigator.pop(context);
  }

}