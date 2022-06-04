import 'package:flutter/material.dart';

class BookingEditorPage extends StatefulWidget {
  const BookingEditorPage({Key? key}) : super(key: key);

  @override
  State<BookingEditorPage> createState() => _BookingEditorPageState();
}

class _BookingEditorPageState extends State<BookingEditorPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
