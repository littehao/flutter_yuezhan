import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/provider/room_provider.dart';
import 'package:yuezhan_app/pages/widget/textfield_widget.dart';
import 'package:yuezhan_app/utils/route_base.dart';
import 'dart:io';

class CreateRoomPage extends StatefulWidget {
  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends BasePage<CreateRoomPage> {
  ///游戏专区
  int specialzone = 0;
  ///报名费
  List num = [];

  int numIndex = 0;
  /// 规则
  List rules = ["胜利方平分奖金"];
  int rulesIndex = 0;
  ///房间信息
  Map<String,dynamic> room;

  ///房间标题焦点控制
  FocusNode createRoomTitleFieldNode = new FocusNode();
  ///房间密码
  FocusNode  createRoomPwdFieldNode = new FocusNode();
  ///赛事码
  FocusNode createRoomCodeFieldNode = new FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var platform = Platform.isIOS?2:1;
    this.room = {
      "title":null,
      "gameZone":1,
      "password":null,
      "roomEnroll":null,
      "rewardRule":rules[0],
      "matchCode":null,
      "gameSys":platform
    };

    WidgetsBinding.instance.addPostFrameCallback((mag) {
      getEnrollConf();
    });
  }
  ///get 报名费
  void getEnrollConf() async{
    var provider = Provider.of<RoomProvider>(context,listen: false);
    provider.loadingg(true);
    var json = await provider.getEnrollConf();
    provider.loadingg(false);
    if(json["code"] == 200){
      this.num = json["data"];
      this.room["roomEnroll"] = num[0];
      setState(() {});
    }
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
      child:Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor:Colors.transparent,
          centerTitle: true,
          title: Text("创建房间",style: TextStyle(fontSize: 18),),
          leading: InkWell(
            onTap: (){
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
            ),
          ),
        ),
        body: buildBodyWidget(),
      ),
    );
  }

  buildBodyWidget(){
    var provider = Provider.of<RoomProvider>(context);
    if(provider.loading){
      return Center(child: BallSpinFadeLoaderIndicator(
        radius: 20,
        ballColor: Color(0xFFAFCAF0),
      ));
    }
    return GestureDetector(
      onTap: (){
        //隐藏键盘
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        createRoomTitleFieldNode.unfocus();
        createRoomPwdFieldNode.unfocus();
        createRoomCodeFieldNode.unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0x60132035)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSpecialZone(),
                  SizedBox(height: 10,),
                  TextInputWidget(title:"房间名称:",hintText:"请输入房间名称",focusNode: createRoomTitleFieldNode,onChanged:(value){
                    this.room['title'] = value;
                  }),
                  SizedBox(height: 10,),
                  TextInputWidget(title:"房间密码:",hintText:"不填则无密码",obscureText:true,focusNode: createRoomPwdFieldNode,onChanged:(value){
                    this.room['password'] = value;
                  }),
                  SizedBox(height: 10,),
                  ///报名费
                  buildSignUpMoney(),
                  SizedBox(height: 10,),
                  buildRewardRules(),
                  SizedBox(height: 10,),
                  TextInputWidget(title:"赛事码:",hintText:"请输入正确赛事码",focusNode: createRoomCodeFieldNode,onChanged:(value){
                    this.room['matchCode'] = value;
                  }),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){},
                    child: Text("如何获取赛事码？",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 10),),
                  )
                ],
              ),
            ),
            SizedBox(height: 50,),
            buildSubmitButtton(),
          ],
        ),
      ),
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
                  room["gameZone"] = index + 1;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(64),
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: room["gameZone"] == (index  + 1)?Color(0xFFF2A93B):Color(0xFF203352)),
                    borderRadius: BorderRadius.circular(2)
                ),
                child: Text("${tabs[index]}",style: TextStyle(color: room["gameZone"] == (index  + 1)?Color(0xFFF2A93B):Color(0xFF51637F),fontSize: 12),),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  ///报名费列表
  buildSignUpMoney() {
    List<Widget> list = List<Widget>();
    for(int i=0;i<num.length;i++){
      list.add(InkWell(
        onTap: (){
          setState(() {
            numIndex = i;
          });
          room["roomEnroll"] = num[i];
        },
        child: Container(
          width: ScreenUtil().setWidth(106),
          height: ScreenUtil().setHeight(64),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: numIndex == i?Color(0xFFF2A93B):Color(0xFF203352)),
              borderRadius: BorderRadius.circular(2)
          ),
          child: Text("${num[i]}",style: TextStyle(color: numIndex == i?Color(0xFFF2A93B):Color(0xFF51637F),fontSize: 12),),
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("报名费:",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
        SizedBox(height: 10,),
        Wrap(
          spacing: 13,
          runSpacing: 15,
          children: list
        )
      ],
    );
  }
  ///奖励规则
  buildRewardRules() {
    List<Widget> list = List<Widget>();
    for(int i=0;i<rules.length;i++){
      list.add(InkWell(
        onTap: (){
          rulesIndex = i;
          room["rewardRule"] = rules[i];
          setState(() {});
        },
        child: Container(
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(64),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: rulesIndex == i?Color(0xFFF2A93B):Color(0xFF203352)),
              borderRadius: BorderRadius.circular(2)
          ),
          child: Text("${rules[i]}",style: TextStyle(color: rulesIndex == i?Color(0xFFF2A93B):Color(0xFF51637F),fontSize: 12),),
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("奖励规则:",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
        SizedBox(height: 10,),
        Wrap(
            spacing: 13,
            runSpacing: 15,
            children: list
        )
      ],
    );
  }

  buildSubmitButtton() {
    var provider = Provider.of<RoomProvider>(context,listen: false);
    return Container(
      width: ScreenUtil().setWidth(710),
      height: ScreenUtil().setHeight(70),
      child: RaisedButton(
        onPressed: (){
          var data = {...room};
          print(data);
          provider.addRoom(data,success: (json){
            // print(json);
            EasyLoading.showToast('${json['msg']}');
            if(json["code"] == 200){
              Future.delayed(Duration(seconds: 2),(){
                pushHomePage();
              });
            }
          },fail: (err){
            EasyLoading.showToast('${err['msg']}');
            print(err);
          });
        },
        elevation: 0,
        color: Color(0xFFF2A93B),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide.none
        ),
        child: Text("确定创建",style: TextStyle(color: Colors.white,fontSize: 15),),
      ),
    );
  }
}
