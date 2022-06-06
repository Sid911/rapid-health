import 'package:hive/hive.dart';

part 'chat_data.g.dart';

@HiveType(typeId: 5, adapterName: "ChatMessageAdapter")
class ChatMessage {
  ChatMessage(this.senderID, this.receiverID, this.messageSent, this.data);
  @HiveField(0)
  final String senderID;
  @HiveField(1)
  final String receiverID;
  @HiveField(2)
  final DateTime messageSent;
  @HiveField(3)
  final String data;
}

@HiveType(typeId: 4, adapterName: "ChatDataAdapter")
class ChatData {
  ChatData(this.targetID, this.originID, this.hashKey, this.messages);
  @HiveField(0)
  final String targetID;
  @HiveField(1)
  final String originID;
  @HiveField(2)
  final String hashKey;
  @HiveField(3)
  final List<ChatMessage> messages;

  ChatPreview toChatPreview(bool originIsTarget) {
    final preview = ChatPreview(
      originIsTarget ? originID : targetID,
      hashKey,
      messages.last.data,
      messages.last.messageSent,
    );
    return preview;
  }
}

@HiveType(typeId: 6, adapterName: "ChatPreviewAdapter")
class ChatPreview {
  ChatPreview(
      this.targetUID, this.chatHash, this.lastMessage, this.lastMessageTime);
  @HiveField(0)
  final String targetUID;
  @HiveField(1)
  final String chatHash;
  @HiveField(2)
  final String lastMessage;
  @HiveField(3)
  final DateTime lastMessageTime;
}

@HiveType(typeId: 3, adapterName: "ChatAdapter")
class Chat {
  Chat(this.chats, this.userUID);
  @HiveField(0)
  final List<ChatPreview> chats;
  @HiveField(1)
  final String userUID;
}
