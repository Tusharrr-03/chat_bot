import 'dart:convert';

import 'package:chat_bot/data/remote/app_urls.dart';
import 'package:chat_bot/data/remote/helper/api_helper.dart';

class ChatRepo{
  ApiHelper apiHelper;
  ChatRepo({required this.apiHelper});

  Future<dynamic> getAllResponse(String msg) async{
    try{
      dynamic res = await apiHelper.postApi(url: AppUrls.baseURl,msg: msg);
      return res;
    } catch (e){
      rethrow;
    }

  }
}