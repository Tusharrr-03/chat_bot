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
