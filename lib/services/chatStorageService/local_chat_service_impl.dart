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
  Future<String> addMessage(
    ChatMessage message, {
    String? conversationHash,
  }) async {
    return await LocalServer.addMessage(message, conversationHash);
  }

  @override
  Future<void> deleteConversation(String conversationHash) async {
    // TODO: implement deleteConversation
    throw UnimplementedError();
  }

  @override
  Future<ValueListenable<Box<ChatData>>?> getConversationListenable(
    String conversationHash,
  ) async {
    if (!LocalServer.conversationBox.containsKey(conversationHash)) {
      return null;
    }
    return LocalServer.conversationBox.listenable(keys: [conversationHash]);
  }

  @override
  Future<ChatPreview?> getChatPreview(UserUID user, UserUID target) async {
    if (LocalServer.chatsBox.containsKey(user.toString())) {
      final chats = LocalServer.chatsBox.get(user.toString())!;
      for (final chat in chats.chats) {
        if (chat.targetUID == target.toString()) {
          return chat;
        }
      }
    }
    return null;
  }
}
