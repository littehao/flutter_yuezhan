import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/bezier_hour_glass_header.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/room/room_index_page.dart';
import 'package:yuezhan_app/pages/sign/sign_in_page.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';
import 'package:yuezhan_app/provider/other_provider.dart';
import 'package:yuezhan_app/provider/user_provider.dart';
import 'package:yuezhan_app/utils/route_base.dart';
import 'package:yuezhan_app/pages/createroom/create_room.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends BasePage<MatchPage>{
  List roomList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      var provider = Provider.of<OtherProvider>(context,listen: false);
      provider.loadingg(true);
      getRoomAllList();
    });
  }

  ///获取可加入房间列表
   void getRoomAllList() async{
    var provider = Provider.of<OtherProvider>(context,listen: false);
    var json = await provider.roomAllList();
    provider.loadingg(false);
    print(json);
    if(json['code'] == 200){
      this.roomList = json["data"];
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent ,
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: _buildHeaderInput(),
            ),
            Positioned(
              top:ScreenUtil().setHeight(90),
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildListView(),
            ),
            buildCreateRoomButton(),
          ],
        ),
      ),
    );
  }

  _buildHeaderInput(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().setWidth(500),
            height: ScreenUtil().setHeight(80),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Color(0xFF132035),
                border:Border.all(width: 2,color: Color(0xFF162339)),
                borderRadius: BorderRadius.circular(4)
            ),
            child: TextField(
              maxLines: 1,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  isCollapsed: true,
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                  hintText: "请输入房间号",
                  hintStyle: TextStyle(color: Color(0xFF51637F),fontSize: 12)
              ),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: ScreenUtil().setWidth(180),
            height: ScreenUtil().setHeight(74),
            child: RaisedButton(
              onPressed: (){},
              color: Color(0xFF132035),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text("申请加入",style: TextStyle(color: Colors.white,fontSize: 12),),
            ),
          )
        ],
      ),
    );
  }

  _buildListView(){
    return Container(
      child: Consumer<OtherProvider>(
        builder: (_,provider,__){
          if(provider.loading){
            return Center(child: BallSpinFadeLoaderIndicator(
              radius: 20,
              ballColor: Color(0xFFAFCAF0),
            ));
          }
          return EasyRefresh(
            onRefresh:() async{
              getRoomAllList();
            },
            onLoad: () async{},
            header: BezierHourGlassHeader(
              backgroundColor: Color(0xFF132035),
              color: Color(0xFF51637F)
            ),
            footer: BezierBounceFooter(
                backgroundColor: Color(0xFF132035),
                color: Color(0xFFAFCAF0)
            ),
            child: ListView.builder(
              itemCount: roomList.length,
              itemBuilder: (context,index){
                return buildMatchItem(index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildMatchItem(int index) {
      var provider =  Provider.of<EnterRoomPwdProvider>(context);
      var userProvider = Provider.of<UserProvider>(context);
      var item = roomList[index];
      return InkWell(
        onTap: (){
          if(userProvider.token == null){
            pushPage(SignInPage());
            return;
          }
          if(item['user_id'] == userProvider.userInfoData['id']){
            pushPage(RoomIndexPage());
            return;
          }
          provider.setPwdAlertShow(true);
        },
        child: Container(
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
                  Text("${item['title']}(${item['game_zone'] == 1?'微信':'QQ'}专区)",style: TextStyle(color: Colors.white,fontSize: 12,),overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5,),
                  Text("房间号：${item['room_code']}",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 10),)
                ],
              ),),
              SizedBox(width: 30,),
              Expanded(flex: 1,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("费用:${item['room_proport']}金币",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 10),),
                  item['password'] != null?Icon(IconData(0xe6c8,fontFamily: "iconfont"),color: Color(0xFFAFCAF0),size: 20,):Container()
                ],
              ),)
            ],
          ),
        ),
      );
  }

  buildCreateRoomButton() {
    return Align(
      alignment: Alignment(0.95,0.95),
      child: InkWell(
        onTap: (){
          // pushPage(CreateRoomPage());
          Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context) => CreateRoomPage())).then((value){
            getRoomAllList();
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xFF132035),
              borderRadius: BorderRadius.circular(50)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("创建",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("房间",style: TextStyle(color: Color(0xFFAFCAF0),fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
