import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';
import 'package:yuezhan_app/utils/route_base.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'keyboard_alert.dart';
import 'package:yuezhan_app/pages/room/room_index_page.dart';

class EnterRoomPwdAlert extends StatefulWidget {
  @override
  _EnterRoomPwdAlertState createState() => _EnterRoomPwdAlertState();
}

class _EnterRoomPwdAlertState extends BasePage<EnterRoomPwdAlert> {
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<EnterRoomPwdProvider>(context);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: ScreenUtil().setHeight(370),
          child: Container(
            alignment: Alignment.center,
            color: Color.fromRGBO(9, 14, 22, 0.9),
            child: Container(
              width: ScreenUtil().setWidth(640),
              height: ScreenUtil().setHeight(425),
              padding: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  color: Color(0xFF293854),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                children: [
                  Text(
                    "请输入房间密码",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        buildItemPwdBox(provider.pwdskey.length >= 1?"*":null),
                        SizedBox(
                          width: 5,
                        ),
                        buildItemPwdBox(provider.pwdskey.length >= 2?"*":null),
                        SizedBox(
                          width: 5,
                        ),
                        buildItemPwdBox(provider.pwdskey.length >= 3?"*":null),
                        SizedBox(
                          width: 5,
                        ),
                        buildItemPwdBox(provider.pwdskey.length >= 4?"*":null),
                        SizedBox(
                          width: 5,
                        ),
                        buildItemPwdBox(provider.pwdskey.length >= 5?"*":null),
                        SizedBox(
                          width: 5,
                        ),
                        buildItemPwdBox(provider.pwdskey.length >= 6?"*":null),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(68),),
                  Divider(color: Color(0xFF3E5884),height: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(flex: 1,child: Container(
                        height: ScreenUtil().setHeight(120),
                        child: RaisedButton(
                          color: Colors.transparent,
                          elevation: 0,
                          splashColor: Color(0xFF51637F),
                          highlightElevation: 0,
                          onPressed: (){
                            provider.setPwdAlertShow(false);
                          },
                          child: Text("返 回",style: TextStyle(color: Color(0xFF51637F),fontSize: 15),),
                        ),
                      ),),
                      SizedBox(width: 0.5,height: ScreenUtil().setHeight(120),child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xFF3E5884)),
                      ),),
                      Expanded(flex: 1,child: Container(
                        height: ScreenUtil().setHeight(120),
                        child: RaisedButton(
                          color: Colors.transparent,
                          splashColor: Color(0xFF51637F),
                          highlightElevation: 0,
                          elevation: 0,
                          onPressed:  (){
                            if(provider.pwds.length >= 6){
                              provider.setPwdAlertShow(false);
                              pushPage(RoomIndexPage());
                            }else{
                              EasyLoading.showToast('密码错误');
                            }
                          },
                          child: Text("确 定",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 15)),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ///自定义键盘
        Align(
          alignment: Alignment.bottomCenter,
          child: KeyboardAlert(),
        )
      ],
    );
  }

  buildItemPwdBox(String pwdNum) {
    if(pwdNum == null){
      return Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(96),
        decoration: BoxDecoration(
            color: Color(0xFF132035),
            borderRadius: BorderRadius.circular(4)),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        "$pwdNum",
        style: TextStyle(
            color: Color(0xFFAFCAF0), fontSize: 20),
      ),
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(96),
      decoration: BoxDecoration(
          color: Color(0xFF132035),
          borderRadius: BorderRadius.circular(4)),
    );
  }
}
