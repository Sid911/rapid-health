import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Create Post"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FlutterRemix.add_line,
          color: theme.textTheme.bodyText1?.color,
        ),
        onPressed: () {},
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Something very formal. Maybe your company name or service you are offering!",
                  helperMaxLines: 2,
                ),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Please enter the full title';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Subtitle",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText: "Your moto or anything catchy !",
                ),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Please enter an elaborate subtitle';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Describe your service well. This will be the details people will read while selecting the service.",
                  helperMaxLines: 2,
                ),
                maxLength: 500,
                maxLines: 12,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 50) {
                    return 'Please enter an elaborate description';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Address to avail the service. Note: This must be accurate enough to lead the user on their own.",
                  helperMaxLines: 2,
                ),
                maxLength: 100,
                maxLines: 3,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 15) {
                    return 'Please enter an elaborate address';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
