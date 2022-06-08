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
    final darkMode = theme.brightness == Brightness.dark;
    final avatarColor = targetUUID.isDoctor
        ? darkMode
            ? Colors.blueGrey.shade900
            : Colors.blueGrey.shade50
        : theme.scaffoldBackgroundColor;

    final background = (targetUUID.isDoctor
        ? darkMode
            ? Colors.blueGrey.shade800
            : Colors.blueGrey.shade100
        : theme.primaryColor);

    String initials = "";
    for (String s in data.name.split(" ")) {
      initials += s[0];
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConversationPage(
              data: data,
              uUID: targetUUID,
              hash: preview.chatHash,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: avatarColor,
                    child: Text(
                      initials,
                      style: theme.textTheme.headline5,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        preview.lastMessage,
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
