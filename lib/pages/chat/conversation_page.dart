import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/pages/chat/message_container.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

import 'message_input.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage(
      {Key? key, required this.data, required this.uUID, this.hash})
      : super(key: key);
  final UserData data;
  final UserUID uUID;
  final String? hash;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late UserData data;
  late UserUID uid;
  late String? hash;

  late User user;
  late ChatServiceInterface chatService;
  late AuthServiceInterface authServiceInterface;
  final _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    data = widget.data;
    uid = widget.uUID;
    hash = widget.hash;
    chatService = context.read<ChatServiceInterface>();
    authServiceInterface = context.read<AuthServiceInterface>();
    user = authServiceInterface.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    // conversation page
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    final appBarColor = uid.isDoctor
        ? darkMode
            ? Colors.blueGrey.shade900
            : Colors.blueGrey.shade50
        : theme.scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(FlutterRemix.arrow_left_s_line),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text.rich(
            TextSpan(
              text: data.name,
              children: [
                TextSpan(
                  text: '\n${data.email}',
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
            style: theme.textTheme.bodyText1,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: hash != null
                    ? FutureBuilder<ValueListenable<Object>?>(
                        future: chatService.getConversationListenable(hash!),
                        builder: (context, snap) {
                          if (!snap.hasData) {
                            return const NotFoundWrapper(
                              text: "No messages Yet!",
                              height: 100,
                            );
                          }

                          return ValueListenableBuilder<Object>(
                            valueListenable: snap.data!,
                            builder: (context, obj, child) {
                              // This is for just this implementation
                              final box = obj as Box<ChatData>;
                              final chatData = box.get(hash)!;
                              return ListView.separated(
                                itemCount: chatData.messages.length,
                                itemBuilder: (context, index) {
                                  return MessageContainer(
                                    message: chatData.messages[index],
                                    currentUUID: user.parsedUID,
                                    otherUUID: uid,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                              );
                            },
                          );
                        })
                    : Container(),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                width: size.width - 80,
                child: MessageInput(controller: _inputController),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: IconButton(
                  onPressed: () async {
                    final message = ChatMessage(
                      user.uid,
                      uid.toString(),
                      DateTime.now(),
                      _inputController.text.trim(),
                    );
                    final newHash = await chatService.addMessage(
                      message,
                      conversationHash: hash,
                    );
                    _inputController.clear();
                    if (hash != newHash) {
                      setState(() {
                        hash = newHash;
                      });
                    }
                  },
                  splashColor: Colors.blue,
                  icon: const Icon(
                    FlutterRemix.send_plane_2_line,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
