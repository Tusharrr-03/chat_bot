import 'package:chat_bot/Screens/dashboard/bloc/chat_event.dart';
import 'package:chat_bot/Screens/dashboard/bloc/chat_state.dart';
import 'package:chat_bot/data/repository/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  ChatRepo chatRepo;

  ChatBloc({required this.chatRepo}) : super(InitialChatState()){

    on<SendMsgEvent>(_onSendMsgEvent);
    on<LoadMsgEvent>(_onLoadMsgEvent);

    on<GetPromptUser>((event, emit) async {
      emit(LoadingChatState());
      try {
        final res = await chatRepo.getAllResponse(event.msg);
        emit(SuccessChatState(response: res));
      } catch (e) {
        emit(FailureChatState(errMsg: e.toString()));
      }
    });

    on<ClearChatEvent>((event, emit){

    });
  }

  /// Firebase Implementation
  Future<void> _onSendMsgEvent(SendMsgEvent event, Emitter<ChatState> emit) async{
    try{
      await chatRepo.addMessage(event.msg);
    } catch(e){
      emit(FailureChatState(errMsg: e.toString()));
    }
  }

  Future<void> _onLoadMsgEvent(LoadMsgEvent event, Emitter<ChatState> emit) async{
    emit(LoadingChatState());
    chatRepo.getMessageStream().listen((message) {
      emit(SuccessChatState(response: message));
    });
  }
}