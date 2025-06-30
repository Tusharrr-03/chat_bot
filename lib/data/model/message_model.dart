class MessageModel {
  int? id; // 0 -> user ,1 -> bot
  String? message;
  String? sentAt;

  MessageModel({required this.id, required this.message, required this.sentAt});

  Map<String, dynamic> toJson() => {
    "id" : id,
    "message" : message,
    "sentAt" : sentAt,
  };

  factory MessageModel.fromJson(String text, int id) {
    return MessageModel(
      id: id,
      message: text,
      sentAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }
}
