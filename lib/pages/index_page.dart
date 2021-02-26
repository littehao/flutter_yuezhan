import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/home/home_page.dart';
import 'package:yuezhan_app/pages/my/my_page.dart';

import 'package:yuezhan_app/pages/widget/enter_room_pwd_alert.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  List<String> tabs = ["赛事","我的"];
  List<IconData> icons = [IconData(0xe605,fontFamily: "iconfont"),IconData(0xe602,fontFamily: "iconfont")];

  @override
  Widget build(BuildContext context) {
    var show = Provider.of<EnterRoomPwdProvider>(context).pwdAlertShow;
    return Scaffold(
      body: Stack(
        children: [
          _buildContainerBody(),
          _buildBottomNavigationBar(),

          ///进入房间输入密码弹窗
          show?EnterRoomPwdAlert():Container(),
        ],
      ),
    );
  }

  _buildContainerBody(){
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: ScreenUtil().setHeight(98),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("static/main_bg.png"),
            fit: BoxFit.fill
          )
        ),
        child: _currentIndex == 0?HomePage():MyPage(),
      ),
    );
  }


  _buildBottomNavigationBar(){
    return  Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: ScreenUtil().setWidth(750),
        color: Color(0xFF162339),
        height:ScreenUtil().setHeight(99),
        child: Row(
          children: _tabs(),
        ),
      ),
    );
  }

  _tabs(){
    List<Widget> list = List<Widget>();
    for(int i =0;i<tabs.length;i++){
      list.add(Expanded(flex: 1,child: Material(
        child: InkWell(
          onTap: (){
            setState(() {
              _currentIndex = i;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF162339),
              image: _currentIndex == i?DecorationImage(
                  image:  AssetImage("static/bottom_tab_bg.png"),
                  fit: BoxFit.fill
              ):null,
            ),
            child: Column(
              children: [
                Icon(icons[i],size: 30,color:_currentIndex == i?Colors.white:Color(0xFF7F8298),),
                SizedBox(height: 2,),
                Text(tabs[i],style: TextStyle(color: _currentIndex == i?Colors.white:Color(0xFF7F8298),fontSize: 12),)
              ],
            ),
          ),
        ),
      ),));
    }


    return list;
  }
}

