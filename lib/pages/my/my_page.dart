import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/invitation/invitation_page.dart';
import 'package:yuezhan_app/pages/my/user_info_page.dart';
import 'package:yuezhan_app/pages/recharge/recharge_page.dart';
import 'package:yuezhan_app/pages/record/game_record_page.dart';
import 'package:yuezhan_app/pages/setup/set_up_page.dart';
import 'package:yuezhan_app/pages/widget/provider_widget.dart';
import 'package:yuezhan_app/provider/user_provider.dart';

import 'package:yuezhan_app/utils/route_base.dart';
import 'package:yuezhan_app/pages/sign/sign_in_page.dart';
import 'package:yuezhan_app/pages/accountbind/account_bind_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends BasePage<MyPage> {

  List linkName = ["约战记录","账号绑定","设置","邀请"];
  List icons = ["static/jilu.png","static/bangding.png","static/shezhi.png","static/share.png"];
  List<Widget> linkPages = [
    GameRcordPage(),
    AccountBindPage(),
    SetUpPage(),
    InvitationPage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("static/my_bg.png"),
                  alignment: Alignment.bottomCenter
              )
          ),
          child: ListView(
            children: [
              SizedBox(height: 50,),
              ///用户头像 昵称
              buildUserInfoWidget(),
              SizedBox(height: 20,),
              /// 充值，金币，兑换
              buildUserToolWidget(),
              SizedBox(height: 50,),
              /// 导航
              buildUserNavsWidget()
            ],
          )
      ),
    );
  }

  buildUserInfoWidget() {
    return Consumer<UserProvider>(
      builder: (_,provider,__){
        var userInfo = provider.userInfoData;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                if(provider.token != null){
                  pushPage(UserInfoPage());
                }else{
                  pushPage(SignInPage());
                }
              },
              child: Container(
                width: ScreenUtil().setWidth(160),
                height: ScreenUtil().setHeight(160),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: provider.token!=null? Container(
                        child: ClipOval(
                          child: Image.asset("static/avatar.jpg",width: ScreenUtil().setWidth(160),fit:BoxFit.fill,),
                        ),
                      ):Container(
                        child: ClipOval(
                          child: Image.asset("static/avatar.png",width: ScreenUtil().setWidth(160),fit:BoxFit.fill,),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.8,0.8),
                      child: Image.asset("static/edit_avatar.png",width: ScreenUtil().setWidth(30),height: ScreenUtil().setHeight(30),),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                if(provider.token != null){
                  pushPage(UserInfoPage());
                }else{
                  pushPage(SignInPage());
                }
              },
              child: Text(provider.token!=null?"竞猜之王":"登录",style: TextStyle(fontSize: 24,color: Colors.white)),
            ),
            SizedBox(height: 5,),
            provider.token!=null?Container(
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
              constraints: BoxConstraints(
                minWidth:60
              ),
              decoration: BoxDecoration(
                  color: Color(0xFF132035),
                  borderRadius: BorderRadius.circular(2),
              ),
              child: userInfo !=null? Text("ID:${userInfo['id']}",style: TextStyle(color: Color(0xFF51637F),fontSize: 10),textAlign: TextAlign.center,):Container(),
            ):Container()
          ],
        );
      },
    );
  }

  buildUserToolWidget() {
    var provider = Provider.of<UserProvider>(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text("${provider.userInfoData['integral']}",style: TextStyle(color: Colors.white,fontSize: 14),),
              SizedBox(height: 5,),
              Text("金币",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12),)
            ],
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              if(provider.token != null){
                pushPage(RechargePage());
              }else{
                pushPage(SignInPage());
              }
            },
            child: Column(
              children: [
                Image.asset("static/chongzhi.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(30),fit: BoxFit.fill,),
                SizedBox(height: 5,),
                Text("充值",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12),)
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              if(provider.token != null){

              }else{
                pushPage(SignInPage());
              }
            },
            child: Column(
              children: [
                Image.asset("static/duihuan.png",width: ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(30),fit: BoxFit.fill,),
                SizedBox(height: 5,),
                Text("兑换",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12),)
              ],
            ),
          ),
        )
      ],
    );
  }

  buildUserNavsWidget() {
    var provider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: linkName.asMap().keys.map((index) {
        return InkWell(
          onTap: (){
            if(provider.token != null){
              pushPage(linkPages[index]);
            }else{
              pushPage(SignInPage());
            }
          },
          child: Container(
            height: ScreenUtil().setHeight(143),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF203352),width: 1))
            ),
            child: Row(
              children: [
                Image.asset("${icons[index]}",width: ScreenUtil().setWidth(32),fit: BoxFit.fill,),
                SizedBox(width: 15,),
                Text("${linkName[index]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                Spacer(flex: 1,),
                Icon(IconData(0xe608,fontFamily: "iconfont"),size: 15,color: Color(0xFFAFCAF0),)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
