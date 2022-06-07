import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/pages/chat/conversation_page.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

class RecentChatsMini extends StatefulWidget {
  const RecentChatsMini({Key? key}) : super(key: key);

  @override
  State<RecentChatsMini> createState() => _RecentChatsMiniState();
}

class _RecentChatsMiniState extends State<RecentChatsMini> {
  late ChatServiceInterface chatService;
  late AuthServiceInterface authService;

  @override
  void initState() {
    super.initState();
    chatService = context.read<ChatServiceInterface>();
    authService = context.read<AuthServiceInterface>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    return FutureBuilder<List<ChatPreview>>(
      future: chatService.getChatPreviews(
        authService.currentUser!.parsedUID,
      ),
      builder: (context, snap) {
        if (snap.hasData) {
          final data = snap.data;
          if (data!.isEmpty) {
            return const NotFoundWrapper(
              text: "No recent chats",
              height: 200,
            );
          }
          return Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: ListView.builder(
              itemCount: data.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final preview = data[index];
                final targetUID = UserUID.fromString(preview.targetUID);
                final avatarColor = targetUID.isDoctor
                    ? darkMode
                        ? Colors.blueGrey.shade900
                        : Colors.blueGrey.shade50
                    : theme.scaffoldBackgroundColor;

                return FutureBuilder<UserData?>(
                  future: authService.getUserData(targetUID),
                  builder: (ctx, userSnap) {
                    if (userSnap.hasData) {
                      final target = userSnap.data!;
                      String initials = "";
                      for (String s in target.name.split(" ").sublist(0, 2)) {
                        initials += s[0];
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ConversationPage(
                                data: target,
                                uUID: targetUID,
                                hash: preview.chatHash,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: GlowContainer(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          color: targetUID.isDoctor
                              ? darkMode
                                  ? Colors.blueGrey.shade700
                                  : Colors.blueGrey.shade200
                              : theme.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          glowColor:
                              darkMode ? Colors.blueGrey : Colors.black26,
                          offset: const Offset(0, 15),
                          spreadRadius: -10,
                          blurRadius: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: avatarColor,
                                child: Text(initials),
                              ),
                              Text(
                                target.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        }

        return const LoadingWrapper(
          height: 200,
        );
      },
    );
  }
}
