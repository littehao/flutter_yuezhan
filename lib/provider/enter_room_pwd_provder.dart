import 'package:yuezhan_app/provider/base_provider.dart';

class EnterRoomPwdProvider extends BaseProvider{
  bool pwdAlertShow = false;
  List pwds = [];
  List pwdskey = [];

  setAddPwds(String keyNum){
    if(pwds.length < 6){
      pwds.add(keyNum);
      pwdskey.add("*");
    }
    notifyListeners();
  }

  ///删除密码

  removeLast(){
    pwds.removeLast();
    pwdskey.removeLast();
    notifyListeners();
  }

  ///显示密码弹窗
  setPwdAlertShow(bool show){
    pwdAlertShow = show;
    if(!show){
      pwds.clear();
      pwdskey.clear();
    }
    notifyListeners();
  }
}