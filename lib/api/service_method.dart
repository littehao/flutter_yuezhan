import "package:dio/dio.dart";
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import "package:yuezhan_app/api/base_url.dart";
import 'dart:convert';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(dynamic json);
typedef After = void Function();


createDio() async{
  BaseOptions options = new BaseOptions(
    baseUrl: serviceUrl,
    contentType: 'application/x-www-form-urlencoded',
    responseType: ResponseType.json,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  // print(token);
  if(token != " " && token !=null){
    Map<String, dynamic> headers = {"token":token};
    options.headers = headers;
  }
  Dio dio = new Dio(options);
  return dio;
}

//post
Future dioPost(url,{formData,Success success, Fail fail, After after}) async{
  try{
    Response response;
    Dio dio = await createDio();

    String apiUrl = servicePath[url];
    if(formData == null){
      response = await dio.post(apiUrl);
    }else{
      response = await dio.post(apiUrl,data:formData);
    }
    if (response.statusCode == 200) {
      if (success != null) {
        success(response.data);
      }else{
        return response.data;
      }
    } else {
      if (fail != null) {
        fail(response);
      }else{
        return response;
      }
    }

    if (after != null) {
      after();
    }
  }catch(error){
    // print(error.response);
    var err = json.decode(error.response.toString());
    if (fail != null && error.response != null) {
      fail(err);
    }else{
      fail("请求失败");
    }
  }
  return Future.value();
}

//get
Future dioGet(url,{formData,Success success, Fail fail, After after}) async{
  try{
    Response response;
    Dio dio =  await createDio();
    String apiUrl = servicePath[url];
    if(formData == null){
      response = await dio.get(apiUrl);
    }else{
      response = await dio.get(apiUrl,queryParameters:formData);
    }
    print(response);
    if (response.statusCode == 200) {
      if (success != null) {
        success(response.data);
      }else{
        return response.data;
      }
    } else {
      if (fail != null) {
        fail(response);
      }else{
        return response;
      }
    }

    if (after != null) {
      after();
    }

  }catch(error){
    var err = json.decode(error.response.toString());
    if(err  != null){
      if (fail != null) {
        fail(err);
      }else{
        return err;
      }
    }else{
      return "服务器访问失败，请检查链接";
    }

  }
  return Future.value();
}