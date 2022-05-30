import 'package:flutter/material.dart';
import 'package:rapid_health/global/post_preview.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:provider/provider.dart';
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
  late List<PostPreview> previews;
  late DoctorData doc;
  final _listState = GlobalKey<AnimatedListState>(debugLabel: "DoctorPosts");
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
    return AnimatedList(
      shrinkWrap: true,
      initialItemCount: 0,
      key: _listState,
      itemBuilder: (BuildContext context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: PostPreviewWidget(
            preview: previews[index],
          ),
        );
      },
    );
  }
}
