import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvitationPage extends StatefulWidget {
  @override
  _InvitationPageState createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
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
        title: Text("邀请"),
        actions: [
          InkWell(
            onTap: (){},
            child: Container(
              margin: EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text("邀请好友",style: TextStyle(color: Color(0xFFF2A93B),fontSize: 14),),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            Image.asset("static/invitation_banner.png",width: ScreenUtil().setWidth(750),fit: BoxFit.fill,),
            SizedBox(height: 15,),
            ///我的邀请
            buildMyInvitationWidget(),
            SizedBox(height: 15,),
            ///我的好友
            buildMyFriendsWidget(),
          ],
        ),
      ),
    );
  }

  buildMyInvitationWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("我的邀请",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 15),),
          Container(
            color: Color.fromRGBO(19, 32, 53, 0.6),
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 1,child: Text("邀请人数：265",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 13)),),
                    Expanded(flex: 1,child: Text("邀请奖励：2654",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12)),),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(flex: 1,child: Text("直属流水：2654",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12)),),
                    Expanded(flex: 1,child: Text("团队流水：26554",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 12)),),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  buildMyFriendsWidget() {
    List<Widget> children = List<Widget>();
    children.add(Text("我的好友",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 15),));
    children.add(SizedBox(height: 5,));
    for(int i=0;i<10;i++){
      children.add(
        Container(
          width: ScreenUtil().setWidth(710),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: Color.fromRGBO(19, 32, 53, 0.6),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundImage: AssetImage("static/default.png"),
              ),
              SizedBox(width: 10,),
              Expanded(flex: 1,child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(flex: 2,child: Text("张大仙",style: TextStyle(color: Colors.white,fontSize: 14),),),
                      Expanded(flex: 2,child: Text("邀请人数：565",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 13)),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(flex: 2,child: Text("ID：5622665",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 13)),),
                      Expanded(flex: 2,child: Text("总流水：5655",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 13)),),
                    ],
                  )
                ],
              ),)
            ],
          ),
        )
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
