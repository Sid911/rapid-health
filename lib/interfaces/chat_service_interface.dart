import 'package:flutter/foundation.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/utility/user.dart';

/// Todo: Docs
abstract class ChatServiceInterface {
  ///
  Future<List<ChatPreview>> getChatPreviews(UserUID uUID);

  ///
  Future<ChatPreview?> getChatPreview(UserUID user, UserUID target);

  ///
  Future<ChatData?> loadChatData(String conversationHash);

  ///
  Future<String> addMessage(
    ChatMessage message, {
    String? conversationHash,
  });

  ///
  Future<void> deleteConversation(String conversationHash);

  ///
  Future<ValueListenable<Object>?> getConversationListenable(
    String conversationHash,
  );
}
