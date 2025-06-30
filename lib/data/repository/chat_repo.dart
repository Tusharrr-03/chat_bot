import 'package:chat_bot/data/model/message_model.dart';
import 'package:chat_bot/data/remote/app_urls.dart';
import 'package:chat_bot/data/remote/helper/api_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepo {
  ApiHelper apiHelper;
  FirebaseFirestore firebaseFirestore;

  ChatRepo({required this.apiHelper, required this.firebaseFirestore});


  /// Getting all Responses from the API
  Future<dynamic> getAllResponse(String msg) async {
    try {
      dynamic res = await apiHelper.postApi(url: AppUrls.baseURl, msg: msg);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  /// Creating the collection for firebase and chat history
  Future<void> addMessage(MessageModel msg) async {
    try{
      await firebaseFirestore.collection("chat_history").add(msg.toJson());
    } catch (e){
      print("FireStore Error : $e");
    }

  }

  Stream<List<MessageModel>> getMessageStream() {
    return firebaseFirestore
        .collection("chat_history")
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) {
                    final data = doc.data();
                    final text = data["message"] ?? "";
                    final id = data['id'] ?? 0;
                    return MessageModel.fromJson(text, id);
              },).toList()
        );
  }
}
