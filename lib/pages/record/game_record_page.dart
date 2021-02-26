import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameRcordPage extends StatefulWidget {
  @override
  _GameRcordPageState createState() => _GameRcordPageState();
}

class _GameRcordPageState extends State<GameRcordPage> {

  int status = 1;

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
        title: Text("约战记录"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Container(
            height: ScreenUtil().setHeight(145),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Color(0xFF162339),
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5,color: Color(0xFF203352)))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("2021.05.05  15:30"),
                  Text("胜利  58金币",style: TextStyle(color: status == 0? Color(0xFFF2A93B):Color(0xFF62B0A4),fontSize: 14),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
