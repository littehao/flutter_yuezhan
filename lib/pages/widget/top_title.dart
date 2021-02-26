import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitlePage extends StatelessWidget {

  String title;
  TopTitlePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Material(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
            ),
          ),
        ),
        title: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
