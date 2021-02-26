import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';

class TextInputWidget extends StatelessWidget {
  String title;
  String hintText;
  Function onChanged;
  Widget child;
  TextInputType textType = TextInputType.text;
  FocusNode focusNode;
  bool obscureText;///是否是密码

  TextInputWidget({
    this.title,
    this.hintText,
    this.onChanged,
    this.child,
    this.textType,
    this.focusNode,
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.title,style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 14),),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 1,child: Container(
                  height:ScreenUtil().setHeight(64),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF132035),
                  ),
                  child: TextField(
                    onChanged: (value){
                      this.onChanged(value);
                    },
                    maxLines: 1,
                    keyboardType: this.textType,
                    focusNode: this.focusNode,
                    obscureText: this.obscureText != null?this.obscureText:false,
                    autofocus: false,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                        border:InputBorder.none,
                        hintText: this.hintText,
                        hintStyle: TextStyle(color: Color(0xFF51637F), fontSize: 12)),
                  ),
                ),),

                this.child != null?this.child:Container()
              ]
          ),
        ),
      ],
    );
  }
}
