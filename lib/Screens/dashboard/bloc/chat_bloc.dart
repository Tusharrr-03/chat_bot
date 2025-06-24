import 'package:chat_bot/Screens/dashboard/bloc/chat_event.dart';
import 'package:chat_bot/Screens/dashboard/bloc/chat_state.dart';
import 'package:chat_bot/data/model/chat_model.dart';
import 'package:chat_bot/data/repository/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>{
  ChatRepo chatRepo;

  ChatBloc({required this.chatRepo}) : super(InitialChatState()){
    on<GetAllResponse>((event, emit) async{
      print("Event Response : $GetAllResponse");
      emit(LoadingChatState());

      try{
        dynamic res = await chatRepo.getAllResponse();
        print("Resources : $res");

        if (res['candidates'] != null &&
            res['candidates'][0]['content'] != null &&
            res['candidates'][0]['content']['parts'] != null &&
            res['candidates'][0]['content']['parts'][0]['text'] != null) {

          var chatModel = ChatDataModel.fromJson(res);

          emit(SuccessChatState(
            message: chatModel.candidates!.first.content!.parts!.first.text!,
          ));
        }
        else{
          emit(FailureChatState(errMsg: res['error']['text']));
        }
      } catch (e){
        emit(FailureChatState(errMsg: e.toString()));
      }
    });
  }
}