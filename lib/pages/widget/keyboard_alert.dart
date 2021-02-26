import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';

class KeyboardAlert extends StatefulWidget {
  @override
  _KeyboardAlertState createState() => _KeyboardAlertState();
}

class _KeyboardAlertState extends State<KeyboardAlert> {
  List keyboardss = [
    ["1","2","3"],
    ["4","5","6"],
    ["7","8","9"],
    ["","0","x"],
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EnterRoomPwdProvider>(context);

    List<Widget> list = List<Widget>();
    for(int i=0;i<keyboardss.length;i++){
      list.add(Row(
        children: [
          Expanded(flex: 1,child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                  color: Color(0xFF293854),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                highlightColor: Color(0xFF51637F),
                onTap: (){
                  provider.setAddPwds(keyboardss[i][0]);
                },
                child: keyboardss[i][0] == ""?Container():Container(
                  height: ScreenUtil().setHeight(70),
                  alignment: Alignment.center,
                  child: Text("${keyboardss[i][0]}",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14)),
                ),
              ),
            ),
          ),),
          SizedBox(width: 5,),
          Expanded(flex: 1,child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                  color: Color(0xFF293854),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                highlightColor: Color(0xFF51637F),
                onTap: (){
                  provider.setAddPwds(keyboardss[i][1]);
                },
                child: keyboardss[i][1] == ""?Container():Container(
                  height: ScreenUtil().setHeight(70),
                  alignment: Alignment.center,
                  child: Text("${keyboardss[i][1]}",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14)),
                ),
              ),
            ),
          ),),
          SizedBox(width: 5,),
          Expanded(flex: 1,child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                  color:keyboardss[i][2] == "x"?Colors.transparent :Color(0xFF293854),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                highlightColor: Color(0xFF51637F),
                onTap: (){
                  if(keyboardss[i][2] != "x"){
                    provider.setAddPwds(keyboardss[i][2]);
                  }else{
                    if(provider.pwds.isEmpty)return;
                    provider.removeLast();
                  }
                },
                child: Container(
                  height: ScreenUtil().setHeight(70),
                  alignment: Alignment.center,
                  child: Text("${keyboardss[i][2]}",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
                ),
              ),
            ),
          ),)
        ],
      ));
    list.add(SizedBox(height: 10,));
    }

    return Container(
      height: ScreenUtil().setHeight(370),
      padding: EdgeInsets.only(left: 5,right: 5,top: 5),
      decoration: BoxDecoration(
        color: Color(0xFF132035)
      ),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: list,
      ),
    );
  }
}
