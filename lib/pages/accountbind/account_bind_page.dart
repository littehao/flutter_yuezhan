import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yuezhan_app/pages/accountbind/add_account_page.dart';
import 'package:yuezhan_app/pages/widget//top_title.dart';
import 'package:yuezhan_app/utils/route_base.dart';

class AccountBindPage extends StatefulWidget {
  @override
  _AccountBindPageState createState() => _AccountBindPageState();
}

class _AccountBindPageState extends BasePage<AccountBindPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("static/main_bg.png"),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context),
        body: ListView(
          children: [
            Container(
              color: Color.fromRGBO(19, 32, 53, 0.6),
              margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
              child: ListTile(
                leading: ClipRRect(
                  child: Image.asset("static/default.png",width: 46,height: 46,),
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text("老子天下第一"),
                subtitle: Text("微信专区"),
                trailing: Container(
                  width: 60,
                  height: 24,
                  child: RaisedButton(
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Color(0xFF51637F),
                    child: Text("解绑",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12),),
                  ),
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(19, 32, 53, 0.6),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: ClipRRect(
                  child: Image.asset("static/default.png",width: 46,height: 46,),
                  borderRadius: BorderRadius.circular(5),
                ),
                title: Text("老子天下第一"),
                subtitle: Text("微信专区"),
                trailing: Container(
                  width: 60,
                  height: 24,
                  child: RaisedButton(
                    onPressed: (){},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                    ),
                    color: Color(0xFF51637F),
                    child: Text("解绑",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: RaisedButton(
                onPressed: (){
                  pushPage(AddAccountPage());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                color: Color(0xFFF2A93B),
                child: Text("添加账号"),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildAppBar(context) {
    return AppBar(
      leading: InkWell(
        onTap: (){
          Navigator.of(context).pop(context);
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("账号绑定"),
      centerTitle: true,
    );
  }
}
