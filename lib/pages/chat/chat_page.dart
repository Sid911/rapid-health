import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/pages/chat/chat_preview_widget.dart';
import 'package:rapid_health/pages/chat/new_chat.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatServiceInterface chatService;
  late AuthServiceInterface authService;
  late User? user;

  @override
  void initState() {
    super.initState();
    chatService = context.read<ChatServiceInterface>();
    authService = context.read<AuthServiceInterface>();
    user = authService.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: theme.primaryColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewChatPage()),
          );
        },
        label: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(FlutterRemix.add_line),
            ),
            Text(
              "New",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder<List<ChatPreview>>(
            future: chatService.getChatPreviews(user!.parsedUID),
            builder: (context, snap) {
              if (snap.hasData) {
                final data = snap.data!;
                if (data.isEmpty) {
                  return const NotFoundWrapper(
                    text: "No Chats Found",
                  );
                }
                return ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (ctx, index) {
                    final chatPreview = data[index];
                    final targetUUID =
                        UserUID.fromString(chatPreview.targetUID);
                    return buildChatPreview(targetUUID, chatPreview);
                  },
                  separatorBuilder: (ctx, index) {
                    return Divider(
                      thickness: 1,
                      color: theme.scaffoldBackgroundColor,
                    );
                  },
                );
              }
              return const LoadingWrapper();
            },
          ),
        ),
      ),
    );
  }

  FutureBuilder<UserData?> buildChatPreview(
    UserUID targetUUID,
    ChatPreview chatPreview,
  ) {
    return FutureBuilder<UserData?>(
      future: authService.getUserData(targetUUID),
      builder: (ctx, snap) {
        if (!snap.hasData) {
          return const LoadingWrapper();
        }
        if (snap.hasError) {
          return const NotFoundWrapper(
            text: "Error in Retrieving this data!",
            height: 70,
          );
        }
        return ChatPreviewWidget(
          preview: chatPreview,
          data: snap.data!,
          targetUUID: targetUUID,
        );
      },
    );
  }
}
