import 'dart:convert';
import 'dart:io';
import 'package:chat_bot/data/remote/helper/api_exception.dart';
import 'package:http/http.dart' as http;

class ApiHelper{

  /*
    Todo: we hit the post api because
  */
  /// postApi

  Future<dynamic> postApi({
    required String url,
    required String msg,
    Map<String, dynamic>? params,
    Map<String, String>? mHeaders,
    bool isAuth = false
  }) async{

    /*if(isAuth){
     /// use shared prefs to get the token
      mHeaders["Authorization"] = "Gemini API $";
    }*/
    try{
      /*var res = await http.post(
          Uri.parse(url),
        headers: mHeaders,
        body: params!=null ? jsonEncode(params) : null,
      );*/
      final res = await http.post(
        Uri.parse(url),
        headers: mHeaders,
        body: jsonEncode({params,msg}),
      );

      print("Status Code: ${res.statusCode}");
      print("Response Body: ${res.body}");
      print("Response: $res");
      return returnResponse(res);
    } on SocketException catch (e) {
      throw NoInternetException(errorMessage: e.toString());
    } catch(e, stackTrace){
      throw(e.toString(), stackTrace);
    }
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(errorMessage: response.body);

      case 401:
      case 403:
        throw UnauthorizedException(errorMessage: response.body);

      case 500:
      default:
        throw FetchDataException(errorMessage: response.body);

    }
  }
}