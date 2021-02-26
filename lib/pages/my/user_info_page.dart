import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
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
        title: Text("资料"),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          buildSetUpItem("头像",Container(
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("static/avatar.png"),
            ),
          )),
          buildSetUpItem("昵称",Text("天下第一",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),)),
          buildSetUpItem("手机号",Text("187-1066-4077",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),)),
        ],
      ),
    );
  }
  buildSetUpItem(String title,Widget child) {
    return InkWell(
      onTap: (){},
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(145),
        decoration: BoxDecoration(
            color: Color(0xFF162339),
            border: Border(bottom: BorderSide(color: Color(0xFF203352),width: 0.5))
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$title"),
              child
            ],
          ),
          trailing:Icon(IconData(0xe608,fontFamily: "iconfont"),color: Color(0xFFAFCAF0),size:15,),
        ),
      ),
    );
  }
}
