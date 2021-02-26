import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RechargePage extends StatefulWidget {
  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  int pay = 0;

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
        backgroundColor: Color.fromRGBO(23, 19, 27, 0.5),
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("100.34",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Text("金币",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 14))
                  ],
                ),
              ),
              buildRechargrBoxWidget(),
              SizedBox(height: 10,),
              buildPayListWidget(),
              SizedBox(height: 50,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  color: Color(0xFFF2A93B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  onPressed: (){},
                  child: Text("确 认",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildAppBar() {
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
      title: Text("充值"),
      centerTitle: true,
    );
  }

  buildRechargrBoxWidget() {
      return Container(
        padding: EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 30),
        decoration: BoxDecoration(
          color: Color(0x90132035)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("充值金额",style: TextStyle(color: Color(0xFF8DAEE6)),),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF3E5884),width: 0.5))
              ),
              child: Row(
                children: [
                  Text("¥",style: TextStyle(color: Color(0xFF8DAEE6),fontSize: 24),),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "请输入充值金额",
                          hintStyle: TextStyle(
                              color: Color(0xFF51637F),
                              fontSize: 14
                          ),
                          border:OutlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Text("金额",style: TextStyle(color: Color(0xFF8DAEE6)),),
            SizedBox(height: 20,),
            buildNumListWidget(),
          ],
        ),
      );
  }

  buildNumListWidget() {
    List num = ["50","100","500","1000","2000","5000"];
    List<Widget> children = List<Widget>();
    for(int i=0;i<num.length;i++){
      children.add(
          Container(
            width: ScreenUtil().setWidth(210),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFF293854),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Text(num[i]),
          )
      );
    }
    return Container(
      height: 120,
      width: ScreenUtil().setWidth(750),
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2/1,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: children,
      ),
    );
  }

  buildPayListWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      decoration: BoxDecoration(
          color: Color(0x90132035)
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("static/icon-zhifubao.png",width: 30,height: 30,),
                  SizedBox(width: 10,),
                  Text("支付宝"),
                  SizedBox(width: 5,),
                  Expanded(flex: 1,child: Text("单笔限额50~5000"),),
                  Radio(
                    activeColor: Color(0xFFAFCAF0),
                    value: 0,
                    groupValue: this.pay,
                    onChanged: (value) {
                      setState(() {
                        this.pay = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
