 import 'package:yuezhan_app/api/service_method.dart';
import 'package:yuezhan_app/provider/base_provider.dart';

class OtherProvider extends BaseProvider{

  ///获取可加入房间列表
  Future<dynamic> roomAllList() async{
    return dioGet("roomAllList");
  }

}