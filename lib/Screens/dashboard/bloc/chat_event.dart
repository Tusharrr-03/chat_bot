import 'package:chat_bot/data/model/message_model.dart';

abstract class ChatEvent{}

class GetAllResponse extends ChatEvent{

}

class GetPromptUser extends ChatEvent{
  String msg;
  GetPromptUser({required this.msg});
}

class GetPromptBot extends ChatEvent{
  String botMsg;
  GetPromptBot({required this.botMsg});
}

class SendMsgEvent extends ChatEvent {
  final MessageModel msg;
  SendMsgEvent({required this.msg});
}

class LoadMsgEvent extends ChatEvent{}

class ClearChatEvent extends ChatEvent{

}


