import 'package:chat_bot/data/model/message_model.dart';
import 'package:chat_bot/utils/utils_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InitialPage extends StatefulWidget {
  InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  var query = TextEditingController();
  List<MessageModel> msgModel = [];

  @override
  void initState() {
    super.initState();
    msgModel.add(
      MessageModel(
        id: 0,
        message: query.text,
        sentAt: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
    msgModel.add(
      MessageModel(
        id: 1,
        message: "Response from Bot",
        sentAt: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
  }

  DateFormat hrsFormat = DateFormat.Hms();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [

              /// Heading Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Chat",
                      style: mTextStyle16(
                        mColor: Colors.white,
                        mFontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: ' GPT',
                          style: mTextStyle16(
                            mColor: Colors.amber,
                            mFontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.face, color: Colors.white, size: 19),
                  ),
                ],
              ),
              SizedBox(height: 20),

              ///  New chat Option
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      /// Clear the old chats

                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.messenger_outline,
                            color: Colors.white,
                            size: 19,
                          ),
                          Text(
                            "New Chat",
                            style: mTextStyle16(
                              mFontWeight: FontWeight.normal,
                              mColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                          size: 19,
                        ),
                        Text(
                          "History",
                          style: mTextStyle16(
                            mFontWeight: FontWeight.normal,
                            mColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: msgModel.length,
                  reverse: true,
                  itemBuilder: (_, index) {
                    return msgModel[index].id == 0
                        ? userChat(msgModel[index])
                        : botChat(msgModel[index]);
                  },
                ),
              ),
              TextField(
                controller: query,
                minLines: 1,
                maxLines: 7,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.mainColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Write a Question.",
                  hintStyle: mTextStyle16(mColor: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (query.text.trim().isNotEmpty) {
                        msgModel.insert(
                          0,
                          MessageModel(
                            id: 0,
                            message: query.text,
                            sentAt:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          ),
                        );

                        msgModel.insert(
                          1,
                          MessageModel(
                            id: 1,
                            message: "Response from bot",
                            sentAt:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                          ),
                        );
                        setState(() {});
                        query.clear();
                      }
                    },
                    icon: Icon(Icons.arrow_upward),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  // top padding for text
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
                    child: Icon(Icons.mic, color: Colors.grey, size: 19),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userChat(MessageModel msgModel) {
    var time = hrsFormat.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentAt!)),
    );

    return Container(
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21),
          topRight: Radius.circular(21),
          bottomLeft: Radius.circular(21),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(msgModel.message!, style: mTextStyle16(mColor: Colors.white)),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(time, style: mTextStyle12(mColor: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget botChat(MessageModel msgModel) {
    var time = hrsFormat.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentAt!)),
    );

    return Container(
      padding: EdgeInsets.all(11),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21),
          topRight: Radius.circular(21),
          bottomRight: Radius.circular(21),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(msgModel.message!, style: mTextStyle16(mColor: Colors.black)),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(time, style: mTextStyle12(mColor: Colors.black)),
          ),
        ],
      ),
    );
  }
}
