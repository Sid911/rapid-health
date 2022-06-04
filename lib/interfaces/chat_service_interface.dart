import 'package:rapid_health/services/chatStorageService/chat_data.dart';

/// Todo: Docs
abstract class ChatServiceInterface {
  ///
  Future<List<ChatPreview>> getChatPreviews();

  ///
  Future<ChatData> loadChatData();
}
