import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/interfaces/chat_service_interface.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage(
      {Key? key, required this.data, required this.uUID, required this.preview})
      : super(key: key);
  final UserData data;
  final UserUID uUID;
  final ChatPreview preview;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late UserData data;
  late UserUID uid;
  late ChatPreview preview;
  late String initials;

  late ChatServiceInterface chatService;

  PatientData? get pData =>
      widget.uUID.isDoctor ? null : widget.data as PatientData;
  DoctorData? get dData =>
      widget.uUID.isDoctor ? widget.data as DoctorData : null;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    uid = widget.uUID;
    preview = widget.preview;

    String initials = "";
    for (String s in data.name.split(" ")) {
      initials += s[0];
    }
    chatService = context.read<ChatServiceInterface>();
  }

  @override
  Widget build(BuildContext context) {
    // conversation page
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: theme.primaryColor,
              child: Text(
                initials,
                style: theme.textTheme.headline4,
              ),
            ),
            Padding(
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
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ValueListenableBuilder<Object>(
            valueListenable:
                chatService.getConversationListenable(preview.chatHash),
            builder: (context, obj, child) {
              // This is for just this implementation
              final box = obj as Box<ChatData>;
              final chatData = box.get(preview.chatHash)!;
              return ListView.separated(
                itemCount: chatData.messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    color: theme.primaryColor,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
