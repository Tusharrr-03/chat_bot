import 'package:chat_bot/Screens/dashboard/bloc/chat_event.dart';
import 'package:chat_bot/Screens/dashboard/bloc/chat_state.dart';
import 'package:chat_bot/data/repository/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  ChatRepo chatRepo;

  ChatBloc({required this.chatRepo}) : super(InitialChatState()){

    on<GetPromptUser>((event, emit) async {
      emit(LoadingChatState());
      try {
        final res = await chatRepo.getAllResponse(event.msg);
        emit(SuccessChatState(response: res));
      } catch (e) {
        emit(FailureChatState(errMsg: e.toString()));
      }
    });
  }
}