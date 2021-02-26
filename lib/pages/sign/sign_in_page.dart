import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuezhan_app/pages/widget/textfield_widget.dart';

import 'package:yuezhan_app/utils/route_base.dart';
import 'package:yuezhan_app/pages/sign/sign_up_page.dart';
import 'package:yuezhan_app/provider/user_provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends BasePage<SignInPage> {
  String phone;
  String password;

  String phoneNumber;
  String phoneCode;

  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  Timer _countdownTimer;

  int _cureentIndex = 0;
  ///账号焦点控制
  FocusNode userPhoneFieldNode = new FocusNode();
  ///用户密码焦点控制
  FocusNode userPasswordFieldNode = new FocusNode();

  ///手机号短信登录焦点控制
  FocusNode userPhoneMsgFieldNode = new FocusNode();
  ///用户验证码焦点控制
  FocusNode userPhoneCodeFieldNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          //隐藏键盘
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          userPhoneFieldNode.unfocus();
          userPasswordFieldNode.unfocus();

          userPhoneMsgFieldNode.unfocus();
          userPhoneCodeFieldNode.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("static/main_bg.png"),
                  fit: BoxFit.fill
              )
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment(-0.95,-0.9),
                  child: InkWell(
                    onTap: (){
                      popPage();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Color(0xFF8DAEE6),),
                    ),
                  )
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTabs(),
                      SizedBox(height: 25,),
                      buildIsWayLogin(),
                    ],
                  ),
                ),
              ),
              ///登录按钮
              buildLoginButton()
            ],
          ),
        ),
      ),
    );
  }

  buildTabs() {
    return Row(
      children: [
        InkWell(
          child: Text("密码登录",style: TextStyle(color: _cureentIndex == 0?Colors.white :Color(0xFF8DAEE6),fontSize: 16),),
          onTap: (){
            setState(() {
              _cureentIndex = 0;
            });
          },
        ),
        SizedBox(width: 20,),
        InkWell(
          child: Text("短信登录",style: TextStyle(color:_cureentIndex == 1?Colors.white : Color(0xFF8DAEE6),fontSize: 16),),
          onTap: (){
            setState(() {
              _cureentIndex = 1;
            });
          },
        ),
      ],
    );
  }

  buildIsWayLogin(){
    if(_cureentIndex == 0){
      return buildPwdBox();
    }else{
      return buildMsgBox();
    }
  }

  buildPwdBox() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0x60132035),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInputWidget(
              title: "账号",
              hintText: "请输入账号",
              textType: TextInputType.number,
              focusNode: userPhoneFieldNode,
              onChanged: (value) {
                this.phone = value;
              }),
          SizedBox(height: 25,),
          TextInputWidget(title:"密码",hintText:"请输入密码",obscureText:true,focusNode: userPasswordFieldNode,onChanged:(value){
            this.password = value;
          }),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  pushPage(SignUpPage());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text("注册新用户",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 12),),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Text("忘记密码？",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12),),
              )
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  buildMsgBox() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0x60132035),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInputWidget(
              title: "手机号",
              hintText: "请输入手机号",
              textType: TextInputType.number,
              focusNode: userPhoneMsgFieldNode,
              onChanged: (value) {
                this.phoneNumber = value;
              }),
          SizedBox(height: 25,),
          buildGetCodeWidget(),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  pushPage(SignUpPage());
                },
                child: Text("注册新用户",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 12),),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  buildLoginButton() {
    var provider = Provider.of<UserProvider>(context);
    return Align(
        alignment: Alignment(0,0.9),
        child: Container(
          width: ScreenUtil().setWidth(710),
          height: ScreenUtil().setHeight(70),
          child: RaisedButton(
            onPressed: (){
              userPhoneFieldNode.unfocus();
              userPasswordFieldNode.unfocus();

              userPhoneMsgFieldNode.unfocus();
              userPhoneCodeFieldNode.unfocus();

              provider.loadingg(true);
              if(provider.loading){
                EasyLoading.show(status: '登录中');
              }
              if(_cureentIndex == 0){
                provider.accountLogin({"mobile":this.phone,"password":this.password},success: (json) async{
                  // print(json);
                  EasyLoading.showToast(json['msg']);
                  provider.setToken(json["data"]["token"]);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("token", json["data"]["token"]);
                  provider.loadingg(false);
                  Future.delayed(Duration(seconds: 2),(){
                    pushHomePage();
                  });
                },fail: (err){
                  EasyLoading.showToast(err['msg']);
                });
              }else{
                provider.smsLogin({"mobile":this.phoneNumber,"code":this.phoneCode},success: (json) async{
                  print(json);
                  EasyLoading.showToast(json['msg']);
                  provider.setToken(json["data"]["token"]);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("token", json["data"]["token"]);
                  provider.loadingg(false);
                  Future.delayed(Duration(seconds: 2),(){
                    pushHomePage();
                  });
                },fail: (err){
                  EasyLoading.showToast(err['msg']);
                });
              }


            },
            elevation: 0,
            color: Color(0xFFF2A93B),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide.none
            ),
            child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 15),),
          ),
        )
    );
  }

  buildGetCodeWidget() {
    var provider = Provider.of<UserProvider>(context);
    return TextInputWidget(title:"验证码",hintText:"请输入验证码",textType: TextInputType.number,focusNode: userPhoneCodeFieldNode,child: Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setHeight(64),
      margin: EdgeInsets.only(left: 10),
      child: RaisedButton(
        onPressed: (){
          if(this.phoneNumber != null){
            RegExp exp = RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
            bool matched = exp.hasMatch(this.phoneNumber);
            if(!matched){
              EasyLoading.showToast('手机号格式不正确');
              return;
            }
            provider.sendSmsFn({
              "mobile":this.phoneNumber,
              "type":"1"
            },success:(json){
              EasyLoading.showToast('${json["msg"]}');
              if(json['code'] == 200){
                this.reGetCountdown();
              }
            },fail: (err){
              EasyLoading.showToast('${err["msg"]}');
            });
          }else{
            EasyLoading.showToast('手机号不能为空');
            return;
          }
        },
        padding: EdgeInsets.all(0),
        color: Color(0xFF132035),
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(4)
        ),
        child: Text("${this._codeCountdownStr}",style: TextStyle(color: Colors.white,fontSize: 12),),
      ),
    ),onChanged:(value){
      this.phoneCode = value;
    });
  }

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}s';
      _countdownTimer =
      new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}s';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}
