import 'package:yuezhan_app/provider/base_provider.dart';
import 'package:yuezhan_app/api/service_method.dart';

class RoomProvider extends BaseProvider{
  ///解散房间弹窗显示
  bool alertShow = false;
  ///踢人弹窗显示
  bool kickAlertShow = false;
  ///修改赛事码
  bool eventCodeShow = false;

  setAlertShow(bool show){
    alertShow = show;
    notifyListeners();
  }

  setKickAlertShow(bool show){
    kickAlertShow = show;
    notifyListeners();
  }

  setEventCodeShow(bool show){
    eventCodeShow = show;
    notifyListeners();
  }

  ///创建房间
  addRoom(Map data,{Success success,Fail fail}){
    var formData = {
      "title":data["title"],
      "game_zone":data["gameZone"],
      "password":data["password"],
      "room_enroll":data["roomEnroll"],
      "reward_rule":data["rewardRule"],
      "match_code":data["matchCode"],
      "game_sys":data["gameSys"]
    };
    dioPost("addRoom",formData:formData,success: success,fail: fail);
  }

  ///获取报名费配置
  Future<dynamic> getEnrollConf() async{
    return dioGet("getEnrollConf");
  }



}