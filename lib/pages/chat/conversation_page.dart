import 'package:flutter/material.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key, required this.data, required this.uUID})
      : super(key: key);
  final UserData data;
  final UserUID uUID;
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Container()),
    );
  }
}
