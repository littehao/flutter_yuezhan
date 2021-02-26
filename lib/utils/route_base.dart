
import 'package:flutter/cupertino.dart';
import 'package:yuezhan_app/utils/route_utils.dart';
import 'package:yuezhan_app/pages/index_page.dart';

///基类
/// 1[pushPage]  打开页面方法
/// 2 [pushRePage]打开页面 并替换当前显示页面
/// 3 [popPage] 关闭当前页面
abstract class BasePage<T extends StatefulWidget> extends State<T>{
  ///打开页面
  void pushPage(Widget page){
    RouteUtils.pushPage(context, page);
  }

  ///打开页面 并替换当前显示页面
  void pushRePage(Widget page) {
    RouteUtils.pushRePage(context, page);
  }

  ///关闭当前页面
  void popPage() {
    RouteUtils.popPage(context);
  }

  ///打开首页面
  void pushHomePage(){
    RouteUtils.pushHomePage(context,IndexPage());
  }
}