import 'package:yuezhan_app/provider/base_provider.dart';
import 'package:yuezhan_app/api/service_method.dart';

class UserProvider extends BaseProvider{
   String token;
   Map userInfoData;

   setToken(String token){
     this.token = token;
     notifyListeners();
   }

   ///设置用户信息
   setUserInfo(Map data){
     this.userInfoData = data;
     notifyListeners();
   }

   ///注册
   registerFn(Map data,{Success success,Fail fail}){
     var formData = {
       "mobile":data["mobile"],
       "password":data["password"],
       "repassword":data["repassword"],
       "code":data["code"],
       "referral_code":data["referral_code"]
     };
     dioPost("register",formData:formData,success:success,fail: fail);
   }

   ///获取验证码
   sendSmsFn(Map data,{Success success,Fail fail}){
     var formData = {
       "mobile":data["mobile"],
       "type":data["type"],
     };
     dioPost("sendSms",formData:formData,success:success,fail:fail);
   }

   ///账号登陆
   accountLogin(Map data,{Success success,Fail fail}){
     var formData = {
       "mobile":data["mobile"],
       "password":data["password"],
     };
     dioPost("accountLogin",formData:formData,success:success,fail:fail);
   }

   ///短信登陆
   smsLogin(Map data,{Success success,Fail fail}){
     var formData = {
       "mobile":data["mobile"],
       "code":data["code"],
     };
     dioPost("smsLogin",formData:formData,success:success,fail:fail);
   }

   ///用户信息
   userInfo({Success success,Fail fail}){
     dioGet("userInfo",success:success,fail:fail);
   }

    ///用户绑定游戏账户
   addUserBind(Map data,{Success success,Fail fail}){
     dioPost("addUserBind",formData:{...data},success:success,fail:fail);
   }

   ///用户绑定的账户列表
   roleList({Success success,Fail fail}){
     dioGet("roleList",success:success,fail:fail);
   }

   ///用户解绑
   delRole(Map data,{Success success,Fail fail}){
     dioGet("delRole",formData:{...data},success:success,fail:fail);
   }


}