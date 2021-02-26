import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yuezhan_app/provider/enter_room_pwd_provder.dart';
import 'package:yuezhan_app/provider/other_provider.dart';
import 'package:yuezhan_app/provider/room_provider.dart';
import 'package:yuezhan_app/provider/user_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<EnterRoomPwdProvider>(
      create: (_) => EnterRoomPwdProvider()
  ),
  ChangeNotifierProvider<UserProvider>(
      create:(_) => UserProvider()
  ),
  ChangeNotifierProvider<RoomProvider>(
      create:(_) => RoomProvider()
  ),
  ChangeNotifierProvider<OtherProvider>(
      create:(_) => OtherProvider()
  ),
];