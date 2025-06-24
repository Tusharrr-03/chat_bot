import 'package:chat_bot/data/model/chat_model.dart';
import 'package:chat_bot/data/model/message_model.dart';

abstract class ChatState{}

class InitialChatState extends ChatState{}
class LoadingChatState extends ChatState{}
class SuccessChatState extends ChatState{
  //List<ChatDataModel> message;
  final String message;
  SuccessChatState({required this.message});
}
class FailureChatState extends ChatState{
  String errMsg;
  FailureChatState({required this.errMsg});
}