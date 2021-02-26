import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuezhan_app/pages/home/match_page.dart';
import 'package:yuezhan_app/pages/home/my_room_page.dart';
import 'package:yuezhan_app/provider/user_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  int _currentTabIndex =  0;
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =  TabController(length: 2,vsync: this);
    _controller.addListener((){

      if(_controller.index == _controller.animation.value) {
        // 当然只是给index赋值影响不大,最多重复赋值
        setState(() {
          _currentTabIndex = _controller.index;
        });
      }
    });

    isLogin();

  }


  void isLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var provider = Provider.of<UserProvider>(context,listen: false);
    if(token != null){
      provider.setToken(token);
      return provider.userInfo(success: (json){
        // print(json);
        var data = json["data"];
        provider.setUserInfo(data);
        return data;
      },fail: (err){
        print(err);
      });
    }
    // print(token);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0x90132035),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        elevation: 0,
        title: TabBar(
          indicator:BoxDecoration(),
          isScrollable: true,
          onTap: (index){
            setState(() {
              _currentTabIndex = index;
            });
          },
          controller: _controller,
          unselectedLabelColor: Color(0x8DAEE6FF),
          labelColor: Colors.white,
          tabs: [
            Text("赛事广场",style: TextStyle(fontSize: 16),),
            Text("我的房间",style: TextStyle(fontSize: 16),),
          ],
        ),
      ),
      body:TabBarView(
        controller: _controller,
        children: [
          MatchPage(),
          MyRoomPage(),
        ],
      ),
    );
  }
}



