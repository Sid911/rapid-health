import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';

///
///
class LocalChatService extends ChatServiceInterface {
  //two boxes one for previews and one for details
  @override
  List<ChatPreview> getChatPreviews() {
    // TODO: implement getChatPreviews
    throw UnimplementedError();
  }

  @override
  ChatData loadChatData() {
    // TODO: implement loadChatData
    throw UnimplementedError();
  }
}
