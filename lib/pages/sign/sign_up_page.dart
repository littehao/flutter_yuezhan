import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';

import 'package:yuezhan_app/utils/route_base.dart';
import 'package:yuezhan_app/provider/user_provider.dart';
import 'package:yuezhan_app/pages/widget/textfield_widget.dart';

import 'dart:async';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BasePage<SignUpPage> {
  String phone;
  String code = "8888";
  String password;
  String repassword;
  String referralCode = "GNJVT7";
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  Timer _countdownTimer;
  ///手机号焦点控制
  FocusNode userPhoneFieldNode = new FocusNode();
  ///验证码
  FocusNode userCodeFieldNode = new FocusNode();
  ///用户密码焦点控制
  FocusNode userPasswordFieldNode = new FocusNode();
  ///用户确认密码焦点控制
  FocusNode userRePasswordFieldNode = new FocusNode();
  ///用户邀请码
  FocusNode userInviteCodeFieldNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //阻止界面resize
      resizeToAvoidBottomInset : true,
      body: GestureDetector(
        onTap: () {
          //隐藏键盘
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          //输入框失去焦点
          userPhoneFieldNode.unfocus();
          userCodeFieldNode.unfocus();
          userPasswordFieldNode.unfocus();
          userRePasswordFieldNode.unfocus();
          userInviteCodeFieldNode.unfocus();
        },
        child:Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("static/main_bg.png"),
                  fit: BoxFit.fill
              )
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        InkWell(
                          onTap: (){
                            popPage();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Color(0xFF8DAEE6),),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Text("注册",style: TextStyle(color: Colors.white,fontSize: 18),),
                        SizedBox(height: 20,),
                        ///表单输入
                        buildFormBox(),
                        SizedBox(height: 50,),

                        buildSubmitButton()

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }

  buildFormBox() {
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
              focusNode: userPhoneFieldNode,
              onChanged: (value) {
                this.phone = value;
              }),
          SizedBox(height: 10,),
          buildGetCodeWidget(),

          SizedBox(height: 10,),
          TextInputWidget(title:"密码",hintText:"请输入密码",obscureText:true,focusNode: userPasswordFieldNode,onChanged:(value){
            this.password = value;
          }),
          SizedBox(height: 10,),
          TextInputWidget(title:"确认密码",hintText:"请再次输入新密码",obscureText:true,focusNode: userRePasswordFieldNode,onChanged:(value){
            this.repassword = value;
          }),
          SizedBox(height: 10,),
          TextInputWidget(title:"邀请码",hintText:"请输入邀请码",focusNode: userInviteCodeFieldNode,onChanged:(value){
            this.referralCode = value;
          }),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){},
                child: Text("已有账号，登录",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12),),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }


  buildSubmitButton() {
    var provider = Provider.of<UserProvider>(context);
    return Container(
      width: ScreenUtil().setWidth(710),
      height: ScreenUtil().setHeight(70),
      child: RaisedButton(
        onPressed: (){
          userPhoneFieldNode.unfocus();
          userCodeFieldNode.unfocus();
          userPasswordFieldNode.unfocus();
          userRePasswordFieldNode.unfocus();
          userInviteCodeFieldNode.unfocus();
          if(this.phone != null){
            RegExp exp = RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
            bool matched = exp.hasMatch(this.phone);
            if(!matched){
              EasyLoading.showToast('手机号格式不正确');
              return;
            }
          }else{
            EasyLoading.showToast('手机号不能为空');
            return;
          }
          if(this.code == null){
            EasyLoading.showToast('验证码不能为空');
            return;
          }
          if(this.password == null){
            EasyLoading.showToast('密码不能为空');
            return;
          }else if(this.password.length < 6){
            EasyLoading.showToast('密码至少6个字符');
            return;
          }
          if(this.password != this.repassword){
            EasyLoading.showToast('确认密码不一致');
            return;
          }
          provider.loadingg(true);
          if(provider.loading){
            EasyLoading.show(status: '加载中');
          }
          provider.registerFn({
            "mobile":this.phone,
            "password":this.password,
            "repassword":this.repassword,
            "code":this.code,
            "referral_code":this.referralCode
          },success: (json){
            provider.loadingg(false);
            EasyLoading.showToast('${json["msg"]}');
            Future.delayed(Duration(seconds: 2),(){
              if(json['code'] == 200){
                popPage();
              }
            });
          },fail: (err){
            provider.loadingg(false);
            EasyLoading.showToast('${err['msg']}');
          });
        },
        elevation: 0,
        color: Color(0xFFF2A93B),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide.none
        ),
        child: Text("注册",style: TextStyle(color: Colors.white,fontSize: 15),),
      ),
    );
  }

  buildGetCodeWidget() {
    var provider = Provider.of<UserProvider>(context);
    return TextInputWidget(title:"验证码",hintText:"请输入验证码",textType: TextInputType.number,focusNode: userCodeFieldNode,child: Container(
      width: ScreenUtil().setWidth(140),
      height: ScreenUtil().setHeight(64),
      margin: EdgeInsets.only(left: 10),
      child: RaisedButton(
        onPressed: (){
          if(this.phone != null){
            RegExp exp = RegExp(
                r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
            bool matched = exp.hasMatch(this.phone);
            if(!matched){
              EasyLoading.showToast('手机号格式不正确');
              return;
            }
            provider.sendSmsFn({
              "mobile":this.phone,
              "type":"2"
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
      this.code = value;
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
