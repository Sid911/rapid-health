import 'package:flutter/material.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/utility/user.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {Key? key,
      required this.message,
      required this.currentUUID,
      required this.otherUUID})
      : super(key: key);
  final ChatMessage message;
  final UserUID currentUUID;
  final UserUID otherUUID;

  bool get isMyMessage => message.senderID == currentUUID.toString();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.senderID == currentUUID.toString()
                    ? Colors.blueGrey.shade900
                    : theme.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.data,
                style: theme.textTheme.bodyText2,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Text(
                message.messageSent.toString().substring(0, 16),
                style: theme.textTheme.subtitle2,
              ),
            )
          ],
        ),
      ],
    );
  }
}
