import 'package:rapid_health/services/chatStorageService/chat_data.dart';

/// Todo: Docs
abstract class ChatService {
  ///
  List<ChatPreview> getChatPreviews();

  ///
  ChatData loadChatData();
}
