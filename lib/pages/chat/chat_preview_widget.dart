import 'package:flutter/material.dart';
import 'package:rapid_health/pages/chat/conversation_page.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

class ChatPreviewWidget extends StatelessWidget {
  const ChatPreviewWidget({
    Key? key,
    required this.preview,
    required this.data,
    required this.targetUUID,
  }) : super(key: key);
  final ChatPreview preview;
  final UserData data;
  final UserUID targetUUID;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationPage(
              data: data,
              uUID: targetUUID,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        decoration: BoxDecoration(
          color: targetUUID.isDoctor
              ? theme.scaffoldBackgroundColor
              : Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
