import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/provider/room_provider.dart';

class ConfirmAlert extends StatelessWidget {
  String title;
  String desc;
  String leftText;///左面按钮文字
  String rightText;///右面按钮文字
  final Function leftCallBack;
  final Function rightCallBack;
  Widget child;
  ConfirmAlert({
    this.title,
    this.desc,
    this.child,
    this.leftText,
    this.rightText,
    this.leftCallBack,
    this.rightCallBack
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Color.fromRGBO(9, 14, 22, 0.9),
      child: Container(
        width: ScreenUtil().setWidth(640),
        height: ScreenUtil().setHeight(480),
        padding: EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
          color: Color(0xFF293854),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Text(title,style: TextStyle(color: Colors.white,fontSize: 16),),
            SizedBox(height: 20,),
            buildChildWidget(),
            SizedBox(height: 18,),
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
                        this.leftCallBack();
                    },
                    child: Text("${this.leftText}",style: TextStyle(color: Color(0xFF51637F),fontSize: 15),),
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
                    onPressed: (){
                       this.rightCallBack();
                    },
                    child: Text("${this.rightText}",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 15)),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildChildWidget() {
    if(this.child != null){
      return this.child;
    }else{
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: 100,
        child: Text("${this.desc}",style: TextStyle(height: 1.5,color: Color(0xFFAFCAF0),fontSize: 14),),
      );
    }
  }
}
