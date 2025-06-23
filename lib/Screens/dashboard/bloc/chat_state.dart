abstract class ChatState{}

class InitialChatState extends ChatState{}
class LoadingChatState extends ChatState{}
class SuccessChatState extends ChatState{}
class FailureChatState extends ChatState{
  String errMsg;
  FailureChatState({required this.errMsg});
}