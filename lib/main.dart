import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:yuezhan_app/pages/index_page.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';
import 'package:yuezhan_app/provider_setup.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: ()=>MaterialApp(
        title: '约战',
        theme: ThemeData(
          backgroundColor: Color(0xFF162339),
          accentColor: Color(0xFF162339),
          scaffoldBackgroundColor: Color(0xFF1E2B46),
          brightness: Brightness.dark,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: IndexPage(),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      ),
    );
  }
}


