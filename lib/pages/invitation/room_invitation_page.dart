import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RoomInvitationPage extends StatefulWidget {
  @override
  _RoomInvitationPageState createState() => _RoomInvitationPageState();
}

class _RoomInvitationPageState extends State<RoomInvitationPage> {
  int topIndex = 0;

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor:Colors.transparent,
          centerTitle: true,
          title: Text("分享",style: TextStyle(fontSize: 18),),
          leading: InkWell(
            onTap: (){
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(IconData(0xe606,fontFamily: "iconfont"),size: 20,color: Colors.white,),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.only(left: 10),
                child: buildTopBgImage(),
              ),
              SizedBox(height: 20,),
              buildShareImage(),
              SizedBox(height: 35,),
              Container(
                width: ScreenUtil().setWidth(710),
                height: 35,
                child: RaisedButton(
                  onPressed: (){},
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  color: Color(0xFFF2A93B),
                  child: Text("保存图片"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildTopBgImage() {
    List urls = ["static/tu1.png","static/tu2.png","static/tu3.png","static/tu4.png"];
    return ListView(
      scrollDirection: Axis.horizontal,
      children:urls.map((item){
        return InkWell(
          onTap: (){},
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.asset("${item}",width: 80,height: 80,fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                top: 5,
                right: 20,
                child: Image.asset( topIndex == 0?"static/gou.png":"static/gou_on.png",width: 12,height: 12,),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  buildShareImage() {
    return Container(
      width: ScreenUtil().setWidth(710),
      height: 410,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("static/share_border.png"),
              fit: BoxFit.fill
          )
      ),
      child: Column(
        children: [
          Padding(
            child: Image.asset("static/sharebg.png",width:ScreenUtil().setWidth(710),fit: BoxFit.fill,),
            padding: EdgeInsets.symmetric(horizontal: 4,vertical: 5),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("static/default.png"),
                  radius: 23,
                ),
                SizedBox(width: 10,),
                Expanded(flex: 1,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张大仙"),
                    SizedBox(height: 5,),
                    Text("ID：5622665")
                  ],
                ),),
                Container(
                  child: new QrImage(
                    padding: EdgeInsets.all(2),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    data: "https://www.baidu.com/",
                    size: 70,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
