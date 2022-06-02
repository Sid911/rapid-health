import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/pages/post_view/post_view.dart';
import 'package:rapid_health/pages/search/search_widget.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/coordinate.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

import '../../global/post_header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.docPref}) : super(key: key);
  final DoctorCategory? docPref;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SettingsService settings = SettingsService();
  final TextEditingController _searchController = TextEditingController();
  late PostsServiceInterface postsService;

  @override
  void initState() {
    super.initState();
    postsService = context.read<PostsServiceInterface>();
  }

  Widget _buildPosts(BuildContext context, PostData post, ThemeData theme) {
    final Coordinate postCoordinate = Coordinate.fromList(post.coordinates);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostViewPage(
                      postUID: post.postHash,
                      previewData: PostPreview.fromPostData(post),
                    ),
                  ),
                );
              },
              child: PostHeader(postData: PostPreview.fromPostData(post))),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              post.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchWidget(controller: _searchController),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: const Text("Category :"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.docPref == null
                              ? "None"
                              : widget.docPref.toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<PostData>>(
                  future: postsService.getAllPostData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shrinkWrap: true,
                        physics: const PageScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return _buildPosts(context, data[index], theme);
                        },
                      );
                    }

                    return const NotFoundWrapper(
                      text: 'No Similar Posts Found',
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
