import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/author_card.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/interfaces/search_service_interface.dart';
import 'package:rapid_health/pages/post_view/post_view.dart';
import 'package:rapid_health/pages/search/search_widget.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/settingsService/settings_service.dart';
import 'package:rapid_health/utility/coordinate.dart';
import 'package:rapid_health/utility/doctor_categories.dart';
import 'package:rapid_health/utility/user.dart';

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
  late SearchServiceInterface searchService;
  String searchTerm = "";
  @override
  void initState() {
    super.initState();
    postsService = context.read<PostsServiceInterface>();
    searchService = context.read<SearchServiceInterface>();
    _searchController.addListener(() {
      setState(() {
        searchTerm = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Search ... "),
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
                  future: searchService.searchPosts(
                    searchTerm,
                    Coordinate(21, 83),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      if (data.isEmpty) {
                        return const NotFoundWrapper(
                          text: 'No Similar Posts Found',
                        );
                      }
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
                    return const LoadingWrapper();
                  },
                ),
                Divider(
                  color: theme.textTheme.subtitle2?.color,
                  thickness: 2,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text("People"),
                ),
                FutureBuilder<List<User>>(
                  future: searchService.searchPeople(searchTerm),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      final data = snap.data!;
                      if (data.isEmpty) {
                        return const NotFoundWrapper(
                          text: 'No Similar People Found',
                          height: 200,
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shrinkWrap: true,
                        physics: const PageScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return _buildPeople(context, data[index], theme);
                        },
                      );
                    }
                    return const LoadingWrapper();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPosts(BuildContext context, PostData post, ThemeData theme) {
    final Coordinate postCoordinate = Coordinate.fromList(post.coordinates);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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

  Widget _buildPeople(BuildContext context, User data, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: AuthorCard(user: data),
    );
  }
}
