import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: TextField(
              style: theme.textTheme.bodyText1,
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Hero(
                tag: "search",
                child: Icon(
                  darkMode
                      ? FlutterRemix.search_2_line
                      : FlutterRemix.search_2_fill,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
