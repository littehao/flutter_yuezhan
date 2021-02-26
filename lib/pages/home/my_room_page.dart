import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class MyRoomPage extends StatefulWidget {
  @override
  _MyRoomPageState createState() => _MyRoomPageState();
}

class _MyRoomPageState extends State<MyRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent ,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return buildMatchItem(index);
        },
      ),
    );
  }

  Widget buildMatchItem(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
      decoration: BoxDecoration(
        color: Color(0x60132035),
      ),
      child: Row(
        children: [
          ClipRect(
            child: Image.asset("static/default.png",width: ScreenUtil().setWidth(92),height: ScreenUtil().setHeight(92),),
          ),
          SizedBox(width: 10,),
          Expanded(flex: 1,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("西南交大开黑...(微信专区)",style: TextStyle(color: Colors.white,fontSize: 12,),overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5,),
              Text("房间号：456595",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 10),)
            ],
          ),),
          SizedBox(width: 30,),
          Text("费用：20000金币/人",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 10),)
        ],
      ),
    );
  }
}
