import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/author_card.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/pages/post_view/reviews_widget.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

import '../../global/post_preview.dart';
import '../../utility/map_styles.dart';

class PostViewPage extends StatefulWidget {
  const PostViewPage({
    Key? key,
    required this.postUID,
    required this.previewData,
  }) : super(key: key);
  final String postUID;
  final PostPreview previewData;
  @override
  State<PostViewPage> createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  final Completer<GoogleMapController> _controller = Completer();

  late PostsServiceInterface postsService;
  late AuthServiceInterface authService;
  late PostPreview preview;

  @override
  void initState() {
    super.initState();
    postsService = context.read<PostsServiceInterface>();
    authService = context.read<AuthServiceInterface>();
    preview = widget.previewData;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Post Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: preview.postDataHash,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: (darkMode
                                    ? Colors.lightBlueAccent
                                    : Colors.black)
                                .withOpacity(darkMode ? 0.2 : 0.1),
                            offset: const Offset(0, 15),
                            spreadRadius: -10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomChip(
                                    darkMode: darkMode,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Text(
                                      preview.postDate
                                          .toIso8601String()
                                          .substring(0, 10)
                                          .replaceAll("-", "/"),
                                      style: theme.textTheme.subtitle2
                                          ?.copyWith(fontSize: 10),
                                    ),
                                  ),
                                  CustomChip(
                                    darkMode: darkMode,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Text(
                                      preview.postCategory.getString(),
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  CustomChip(
                                    darkMode: darkMode,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: const Text(
                                      "2.5 Km",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: Text(
                              preview.title,
                              style: theme.textTheme.bodyText1,
                              maxLines: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Text(
                              "'${preview.subtitle}'",
                              style: theme.textTheme.subtitle2,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FutureBuilder<PostData?>(
                  future: postsService.getPostData(widget.postUID),
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SubtitleText(theme: theme, string: "Description"),
                        snapshot.hasData
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(data!.description))
                            : const LoadingWrapper(),
                        _SubtitleText(
                          theme: theme,
                          string: "Location",
                        ),
                        if (snapshot.hasData && data != null)
                          SizedBox(
                            height: 300,
                            child: GoogleMap(
                              zoomControlsEnabled: false,
                              zoomGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                              tiltGesturesEnabled: false,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                zoom: 10,
                                target: LatLng(
                                    data.coordinates[0], data.coordinates[1]),
                              ),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("init"),
                                  position: LatLng(
                                      data.coordinates[0], data.coordinates[1]),
                                )
                              },
                              onMapCreated: (GoogleMapController controller) {
                                controller.setMapStyle(
                                  theme.brightness == Brightness.dark
                                      ? MapStyles.dark
                                      : MapStyles.light,
                                );
                                _controller.complete(controller);
                              },
                            ),
                          )
                        else
                          const LoadingWrapper(
                            height: 300,
                          ),
                        _SubtitleText(theme: theme, string: "Author"),
                        if (data != null)
                          FutureBuilder<DoctorData?>(
                            future: authService.getDoctorData(data.authorUID),
                            builder: (context, snap) {
                              if (snap.hasData && snap.data != null) {
                                return AuthorCard(
                                    userData: snap.data!, isDoctor: true);
                              }
                              return const LoadingWrapper();
                            },
                          ),
                        _SubtitleText(theme: theme, string: "Reviews"),
                      ],
                    );
                  },
                ),
                FutureBuilder<Reviews?>(
                  future: postsService.getReviewsForPost(widget.postUID),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return const NotFoundWrapper(text: "No reviews Found");
                    }
                    final data = snapshot.data;
                    if (data != null) {
                      if (data.reviews.isEmpty) {
                        return const NotFoundWrapper(text: "No reviews Found");
                      }
                      return ReviewsWidget(reviews: data);
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
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText({
    Key? key,
    required this.theme,
    required this.string,
    this.margin,
  }) : super(key: key);

  final ThemeData theme;
  final String string;
  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Text(
        string,
        style: theme.textTheme.headline6,
      ),
    );
  }
}
