import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/utility/local_server.dart';
import 'package:rapid_health/utility/user.dart';

///
///
class LocalChatService extends ChatServiceInterface {
  //two boxes one for previews and one for details
  @override
  Future<List<ChatPreview>> getChatPreviews(UserUID uUID) async {
    final result = LocalServer.chatsBox.get(uUID.toString())?.chats;
    return result ?? [];
  }

  @override
  Future<ChatData?> loadChatData(String conversationHash) async {
    return LocalServer.conversationBox.get(conversationHash);
  }

  @override
  Future<void> addMessage(
    ChatMessage message, {
    String? conversationHash,
  }) async {
    await LocalServer.addMessage(message, conversationHash);
  }

  @override
  Future<void> deleteConversation(String conversationHash) async {
    // TODO: implement deleteConversation
    throw UnimplementedError();
  }

  @override
  ValueListenable<Box<ChatData>> getConversationListenable(
    String conversationHash,
  ) {
    return LocalServer.conversationBox.listenable(keys: [conversationHash]);
  }
}
