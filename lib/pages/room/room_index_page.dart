import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/invitation/room_invitation_page.dart';
import 'package:yuezhan_app/provider/room_provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuezhan_app/pages/widget/confirm_alert.dart';
import 'package:yuezhan_app/utils/route_base.dart';

class RoomIndexPage extends StatefulWidget {
  @override
  _RoomIndexPageState createState() => _RoomIndexPageState();
}

class _RoomIndexPageState extends BasePage<RoomIndexPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomProvider>(
      create: (context){
        var provider = new RoomProvider();
        return provider;
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("static/main_bg.png"),
                      fit: BoxFit.fill
                  )
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: InkWell(
                    onTap: (){
                      Navigator.of(context).pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
                    ),
                  ),
                  title: Text("西南交大对黑生死专房(QQ专区)"),
                ),
                body:Stack(
                  children: [
                    buildTopRoomInfoWidget(),
                    Positioned(
                      top:ScreenUtil().setHeight(64),
                      left: 0,
                      right: 0,
                      bottom: ScreenUtil().setHeight(98),
                      child: buildRoomInfoWidget(),
                    ),
                    buildMasterBottomButtonWidget(),
                  ],
                ),
              ),
            ),
          ),
          ///解散房间弹窗
          Consumer<RoomProvider>(builder: (_,provide,__){
            // print(provide.alertShow);
            if(provide.alertShow){
              var msg = "房主解散房间后所有玩家都会退出房间， 严重影响玩家游戏体验。恶意解散会被官方 予以禁止游戏的惩罚，请共同维护游戏环境。";
              return Align(
                alignment: Alignment.topLeft,
                child: ConfirmAlert(
                    title:"解散房间",
                    desc:msg,
                    leftText:"继续退出",
                    rightText:"我再等等",
                    leftCallBack:(){
                        Navigator.pop(context);
                    },
                    rightCallBack:(){
                        provide.setAlertShow(false);
                    })
              );
            }else{
              return Container();
            }
          }),

          ///踢人弹窗
          Consumer<RoomProvider>(builder: (_,provide,__){
            if(provide.kickAlertShow){
              return Align(
                alignment: Alignment.topLeft,
                child: ConfirmAlert(
                    title:"踢人提示",
                    desc:"是否确认将玩家踢出房间",
                    leftText:"返回",
                    rightText:"确定",
                    leftCallBack:(){
                      provide.setKickAlertShow(false);
                    },
                    rightCallBack:(){
                      provide.setKickAlertShow(false);
                    })
              );
            }else{
              return Container();
            }

          }),

          ///修改赛事码
          Consumer<RoomProvider>(builder: (_,provide,__){
            if(provide.eventCodeShow){
              return Align(
                  alignment: Alignment.topLeft,
                  child: ConfirmAlert(
                      title:"请输入赛事码",
                      leftText:"返回",
                      rightText:"确定",
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  hintText: "请输入正确赛事码",
                                  hintStyle: TextStyle(color: Color(0xFF51637F),fontSize: 12),
                                  border:OutlineInputBorder(
                                    borderSide: BorderSide.none
                                  )
                                ),
                                textAlign: TextAlign.center,
                              ),
                              height: ScreenUtil().setHeight(64),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFF132035),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text("如何获取赛事码？",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 10),),
                              ),
                            )
                          ],
                        ),
                      ),
                      leftCallBack:(){
                        provide.setEventCodeShow(false);
                      },
                      rightCallBack:(){
                        provide.setEventCodeShow(false);
                      })
              );
            }else{
              return Container();
            }
          }),
        ],
      ),
    );
  }

  /// 房主底部按钮
  buildMasterBottomButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 19),
        color: Color(0xFF162339),
        height: ScreenUtil().setHeight(98),
        child: Consumer<RoomProvider>(builder: (_,provider,__){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  provider.setEventCodeShow(true);
                },
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(64),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Color(0xFFAFCAF0)),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("修改赛事码",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 15),),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(64),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:Color(0xFFF2A93B) ,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("开 始",style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
              )
            ],
          );
        },)
      ),
    );
  }
  /// 用户底部按钮
  buildUserBottomButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 19),
        color: Color(0xFF162339),
        height: ScreenUtil().setHeight(98),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){},
              child: Container(
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setHeight(64),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:Color(0xFFF2A93B) ,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("进入游戏",style: TextStyle(color: Colors.white,fontSize: 15),),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setHeight(64),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xFFAFCAF0)),
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("开始30S",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 15),),
              ),
            ),

          ],
        ),
      ),
    );
  }
  /// 上传战绩
  buildUploadBottomButtonWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 19,vertical: 5),
        color: Color(0xFF162339),
        height: ScreenUtil().setHeight(98),
        child: InkWell(
          onTap: (){},
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(64),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:Color(0xFFF2A93B) ,
                borderRadius: BorderRadius.circular(50)
            ),
            child: Text("上传战绩截图",style: TextStyle(color: Colors.white,fontSize: 15),),
          ),
        ),
      ),
    );
  }
  ///房间顶部信息
  buildTopRoomInfoWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: ScreenUtil().setHeight(64),
        decoration: BoxDecoration(
            color: Color.fromRGBO(19, 32, 53, 0.6)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("房间号：456595",style: TextStyle(fontSize: 11,color: Color(0xFF8DAEE6))),
            Text("费用：20金币/人",style: TextStyle(fontSize: 11,color: Color(0xFF8DAEE6)),),
            Icon(IconData(0xe6c8,fontFamily: "iconfont"),size: 20,color: Color(0xFFAFCAF0),)
          ],
        ),
      ),
    );
  }


  buildRoomInfoWidget() {
    return Container(
      height: double.infinity,
      child:SingleChildScrollView(
        child: Column(
          children: [
            buildRoomMasterWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Wrap(
                spacing: 35,
                children: buildRoomUserListWidget(),
              ),
            ),
            SizedBox(height: 50,),
            ///比赛规则
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("【比赛规则】",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 15),),
                  SizedBox(height: 10,),
                  Text("比赛规则双方人数满10人之后开始比赛，比赛结束后上传比赛截图，赛后获胜队伍将获得全部奖金并平分给各个玩家。",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12)),
                  SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  ///房主信息
  buildRoomMasterWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF2A93B),width: 1),
                borderRadius: BorderRadius.circular(2)
            ),
            child: Image.asset("static/avatar.jpg",width: 64,height: 64,fit: BoxFit.fill,),
          ),
          Expanded(flex: 1,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("房主",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 15),),
              SizedBox(height: 10,),
              Text("花心大罗卜",style: TextStyle(color: Colors.white,fontSize: 15),overflow: TextOverflow.ellipsis,),
            ],
          ),),
          Column(
            children: [
              Container(
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setHeight(48),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48)
                  ),
                  onPressed: (){
                    pushPage(RoomInvitationPage());
                  },
                  color: Color(0xFF132035),
                  child: Text("邀请",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12),),
                ),
              ),
              SizedBox(height: 10,),
              Consumer<RoomProvider>(builder: (_,provide,__){
                return Container(
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(48),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)
                    ),
                    color: Color(0xFF51637F),
                    onPressed: (){
                      provide.setAlertShow(true);
                    },
                    child: Text("解散",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12),),
                  ),
                );
              })
            ],
          ),
        ],
      ),
    );
  }

  buildRoomUserListWidget() {
    List<Widget> children = List<Widget>();
    for(int i=0;i<9;i++){
      if(i>4){
        children.add(
            Padding(
              padding: EdgeInsets.only(top: 22,left: 2,right: 2),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Color(0xFF203352))
                ),
                child: Image.asset("static/room_user.png",width: 64,height: 64,fit: BoxFit.fill,),
              ),
            )
        );
      }else{
        children.add(
            buildUserItem()
        );
      }
    }
    return children;
  }

  Widget buildUserItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("召唤师名称"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF2A93B),width: 1),
                borderRadius: BorderRadius.circular(2)
            ),
            child: Image.asset("static/avatar.jpg",width: 64,height: 64,fit: BoxFit.fill,),
          ),
          Consumer<RoomProvider>(builder: (_,provide,__){
            return Container(
              width: ScreenUtil().setWidth(100),
              height: ScreenUtil().setHeight(40),
              child: OutlineButton(
                padding: EdgeInsets.all(0),
                borderSide: BorderSide(color: Color(0xFFAFCAF0)),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ) ,
                onPressed: (){
                  provide.setKickAlertShow(true);
                },
                child: Text("踢 出",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 11),),
              ),
            );
          })
        ],
      ),
    );
  }
}
