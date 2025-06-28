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
  }) async{
    try{
      final res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type" : "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text": msg,
                }
              ]
            }
          ]
        })
      );

      if(res.statusCode == true){
        var data = jsonDecode(res.body);

        if(data['Resources'] != null){
          throw(HttpException(data['Resources']['text']));
        }

        return data;
      }

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