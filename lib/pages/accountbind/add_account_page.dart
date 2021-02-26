import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/widget/textfield_widget.dart';
import 'package:yuezhan_app/provider/user_provider.dart';
import 'package:yuezhan_app/utils/route_base.dart';
import 'dart:io';

class AddAccountPage extends StatefulWidget {
  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends BasePage<AddAccountPage> {
  ///游戏专区
  int specialzone = 0;
  Map<String,dynamic> gameInfo;
  ///游戏昵称
  FocusNode gameNickNameFieldNode = new FocusNode();
  ///游戏段位
  FocusNode  gameScoreFieldNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var platform = Platform.isIOS?2:1;
    this.gameInfo = {
      "game_zone":1,
      "game_sys":platform,
      "game_nickname":null,
      "game_score":null
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("static/main_bg.png"),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context),
        body: GestureDetector(
          onTap: (){
            //隐藏键盘
            SystemChannels.textInput.invokeMethod('TextInput.hide');
            gameNickNameFieldNode.unfocus();
            gameScoreFieldNode.unfocus();
          },
          child:Column(
            children: [
              SizedBox(height: 20,),
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 10),
                color: Color.fromRGBO(19, 32, 53, 0.8),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSpecialZone(),
                    SizedBox(height: 10,),
                    TextInputWidget(title:"游戏昵称:",hintText:"请输游戏昵称",focusNode: gameNickNameFieldNode,onChanged:(value){
                      gameInfo['game_nickname'] = value;
                    }),
                    SizedBox(height: 10,),
                    Text("游戏段位:",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: false,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return getRankListWidget();
                            });
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height:ScreenUtil().setHeight(64),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFF132035),
                            ),
                            child: gameInfo["game_score"] != null?Text("111",style: TextStyle(color: Colors.white, fontSize: 14),) :Text("请选择游戏段位",style: TextStyle(color: Color(0xFF51637F), fontSize: 12),),
                          ),
                          Positioned(
                            right: 0,
                            top: 12,
                            child: Icon(Icons.arrow_drop_down,color: Color(0xFF51637F),size: 30,),
                          )
                        ],
                      ),
                    ),
                    // TextInputWidget(title:"游戏段位:",hintText:"请选择游戏段位",focusNode: gameScoreFieldNode,onChanged:(value){
                    //   gameInfo['game_score'] = 1;
                    // }),
                    SizedBox(height: 10,),
                    Text("温馨提示：如绑定的游戏昵称和参与实际比赛的昵称不一致，将会导致赛事无成绩，如有疑问请联系客服",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 10),)
                  ],
                ),
              ),
              SizedBox(height: 100,),
              buildSubmitButton()
            ],
          ),
        ),
      ),
    );
  }

  ///表单
  buildRoomInput(String roomName,String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(roomName,style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
        Container(
          height:ScreenUtil().setHeight(64),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Color(0xFF132035),
          ),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                border:InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: Color(0xFF51637F), fontSize: 12)),
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }


  ///游戏专区
  buildSpecialZone() {
    List tabs = ["微信专区","QQ专区"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("游戏专区:",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
        SizedBox(height: 10,),
        Row(
          children: tabs.asMap().keys.map((index){
            return InkWell(
              onTap: (){
                setState(() {
                  gameInfo["game_zone"] = index + 1;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(64),
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: gameInfo["game_zone"] == (index  + 1)?Color(0xFFF2A93B):Color(0xFF203352)),
                    borderRadius: BorderRadius.circular(2)
                ),
                child: Text("${tabs[index]}",style: TextStyle(color: gameInfo["game_zone"] == (index  + 1)?Color(0xFFF2A93B):Color(0xFF51637F),fontSize: 12),),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  buildAppBar(context) {
    return AppBar(
      leading: InkWell(
        onTap: (){
          Navigator.of(context).pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("添加账号"),
      centerTitle: true,
    );
  }

  buildSubmitButton() {
    var provider = Provider.of<UserProvider>(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: RaisedButton(
        onPressed: (){
          //addUserBind
          // pushPage(AddAccountPage());
          provider.addUserBind({...gameInfo},success: (json){
            print(json);
          },fail: (err){
            print(err);
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        color: Color(0xFFF2A93B),
        child: Text("提交认证"),
      ),
    );
  }

  Widget getRankListWidget() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
      ),
      child:Column(
        children: [
          
        ],
      ),
    );
  }
}
