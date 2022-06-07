import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      constraints: const BoxConstraints(maxHeight: 200),
      child: TextField(
        autofocus: false,
        controller: widget.controller,
        style: theme.textTheme.bodyText1,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onSubmitted: (s) {},
        minLines: 1,
        maxLines: 30,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
