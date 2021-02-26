import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuezhan_app/provider/user_provider.dart';
import 'package:yuezhan_app/utils/route_base.dart';

class SetUpPage extends StatefulWidget {
  @override
  _SetUpPageState createState() => _SetUpPageState();
}

class _SetUpPageState extends BasePage<SetUpPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF162339),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
          ),
        ),
        centerTitle: true,
        title: Text("设置"),
      ),
      body: ListView(
        children: [
          Divider(height: 5,color: Color(0xFF1E2B46),),
          buildSetUpItem("密码设置"),
          buildSetUpItem("隐私政策"),
          buildSetUpItem("用户协议"),
          buildSetUpItem("关于我们"),
          Divider(height: 5,color: Color(0xFF1E2B46),),
          buildSetUpItem("退出登录",callback:()async{
            provider.setToken(null);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("token");
            pushHomePage();
          }),
        ],
      ),
    );
  }

  buildSetUpItem(String title,{Function callback}) {
    return InkWell(
      onTap: (){
        callback();
      },
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(145),
        decoration: BoxDecoration(
          color: Color(0xFF162339),
          border: Border(bottom: BorderSide(color: Color(0xFF203352),width: 0.5))
        ),
        child: ListTile(
          title: Text("$title"),
          trailing: Icon(IconData(0xe608,fontFamily: "iconfont"),color: Color(0xFFAFCAF0),size:15,),
        ),
      ),
    );
  }
}
