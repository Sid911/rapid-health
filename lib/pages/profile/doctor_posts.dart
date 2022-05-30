import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/post_preview.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';

class ProfileDoctorPosts extends StatefulWidget {
  const ProfileDoctorPosts({Key? key, required this.userData})
      : super(key: key);
  final DoctorData userData;
  @override
  State<ProfileDoctorPosts> createState() => _ProfileDoctorPostsState();
}

class _ProfileDoctorPostsState extends State<ProfileDoctorPosts> {
  late PostsServiceInterface postsService;
  late List<PostPreview> previews = List<PostPreview>.empty(growable: true);
  late DoctorData doc;
  final _listState = GlobalKey<AnimatedListState>(debugLabel: "DoctorPosts");
  bool noPostsFound = false;
  @override
  void initState() {
    super.initState();
    doc = widget.userData;
    postsService = context.read<PostsServiceInterface>();
    _getPostPreviews();
  }

  void _getPostPreviews() async {
    final posts = await postsService.getPosts(doc.email);
    final localPreviews = posts.previews;
    if (localPreviews.isEmpty) {
      setState(() {
        noPostsFound = true;
      });
      return;
    }
    int index = 0;
    for (PostPreview p in localPreviews) {
      previews.add(p);
      _listState.currentState!.insertItem(index);
      await Future.delayed(const Duration(milliseconds: 100));
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            "Posts :",
            style: theme.textTheme.headline4,
          ),
        ),
        if (noPostsFound)
          SizedBox(
            height: 300,
            child: Center(
              child: Text(
                "No Posts Found",
                style: theme.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        AnimatedList(
          shrinkWrap: true,
          key: _listState,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: PostPreviewWidget(
                preview: previews[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
