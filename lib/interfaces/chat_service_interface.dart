import 'package:rapid_health/services/chatStorageService/chat_data.dart';

/// Todo: Docs
abstract class ChatServiceInterface {
  ///
  List<ChatPreview> getChatPreviews();

  ///
  ChatData loadChatData();
}
