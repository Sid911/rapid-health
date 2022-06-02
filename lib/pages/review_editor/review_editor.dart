import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

class ReviewEditorPage extends StatefulWidget {
  const ReviewEditorPage({
    Key? key,
    required this.authorUID,
    required this.postID,
  }) : super(key: key);
  final String authorUID;
  final String postID;
  @override
  State<ReviewEditorPage> createState() => _ReviewEditorPageState();
}

class _ReviewEditorPageState extends State<ReviewEditorPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late PostsServiceInterface postsService;

  @override
  void initState() {
    super.initState();
    postsService = context.read<PostsServiceInterface>();
  }

  void _uploadReview() async {
    final data = ReviewData(
      title: _titleController.text,
      description: _descController.text,
      postDate: DateTime.now(),
      authorUID: widget.authorUID,
    );
    try {
      await postsService.addReview(widget.postID, data);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Review Posted Successfully!")));
      Navigator.pop(context);
    } on Exception catch (e, s) {
      Logger().e("Error posting review", e, s);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot post the review !")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: _uploadReview,
            icon: const Icon(FlutterRemix.send_plane_2_line),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const ReviewQuotes(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _titleController,
                        style: theme.textTheme.bodyText1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          helperText:
                              "Enter brief Title which can help other users",
                          labelStyle: theme.textTheme.bodyText1,
                          labelText: "Title of Review",
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _descController,
                        style: theme.textTheme.bodyText1,
                        maxLengthEnforcement: MaxLengthEnforcement.none,
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          helperText: "Enter a very constructive review.",
                          labelStyle: theme.textTheme.bodyText1,
                          alignLabelWithHint: true,
                          labelText: "Description of Review",
                        ),
                        maxLength: 2000,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewQuotes extends StatelessWidget {
  const ReviewQuotes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkTheme = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: darkTheme ? Colors.blueGrey.shade900 : Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\" When a buyer leaves a negative review, it is a great"
            " opportunity to connect and find out why they did and "
            "how to make your business better. \"",
            style: theme.textTheme.bodyText1?.copyWith(
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "\n\n\ - Chris Gronkowski",
            style: TextStyle(
              fontFamily: "Sacramento",
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
