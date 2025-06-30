
import 'package:chat_bot/data/model/message_model.dart';

abstract class ChatState{}

class InitialChatState extends ChatState{}
class LoadingChatState extends ChatState{}
class SuccessChatState extends ChatState{
  final dynamic response;
  final List<MessageModel>? msg;
  SuccessChatState({required this.response, this.msg});
}
class FailureChatState extends ChatState{
  String errMsg;
  FailureChatState({required this.errMsg});
}