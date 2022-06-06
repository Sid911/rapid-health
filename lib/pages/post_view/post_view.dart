import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/author_card.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/global/post_header.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/pages/bookings_editor/booking_editor.dart';
import 'package:rapid_health/pages/post_view/reviews_widget.dart';
import 'package:rapid_health/pages/review_editor/review_editor.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

import '../../utility/map_styles.dart';

class PostViewPage extends StatefulWidget {
  const PostViewPage({
    Key? key,
    required this.postUID,
    required this.previewData,
  }) : super(key: key);
  final String postUID;
  final PostPreview previewData;
  PostViewPage.fromPostData({
    Key? key,
    required PostData postData,
  })  : postUID = postData.postHash,
        previewData = PostPreview.fromPostData(postData),
        super(key: key);
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
      floatingActionButton: FutureBuilder<PostData?>(
        future: postsService.getPostData(preview.postDataHash),
        builder: (context, snap) {
          if (!snap.hasData) {
            return Container();
          }
          return GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BookingEditorPage(data: snap.data!);
                  },
                ),
              );
            },
            child: GlowContainer(
              borderRadius: BorderRadius.circular(10),
              color: darkMode
                  ? Colors.blueGrey.shade600
                  : Colors.blueGrey.shade200,
              padding: const EdgeInsets.all(15),
              glowColor: Colors.lightBlueAccent,
              spreadRadius: -10,
              offset: const Offset(0, 10),
              blurRadius: 20,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Book Service"),
                  Icon(FlutterRemix.health_book_line),
                ],
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              PostHeader(postData: preview),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Divider(
                          thickness: 5,
                          color: darkMode
                              ? Colors.blueGrey.shade300
                              : Colors.blueGrey.shade700,
                        ),
                      ),
                      _SubtitleText(theme: theme, string: "Location"),
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
                            trafficEnabled: true,
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
                              return AuthorCard(user: snap.data!.toUser());
                            }
                            return const LoadingWrapper();
                          },
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _SubtitleText(theme: theme, string: "Reviews"),
                          if (!authService.isUserDoctor!)
                            Container(
                              decoration: BoxDecoration(
                                color: darkMode
                                    ? Colors.blueGrey.shade600
                                    : Colors.blueGrey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewEditorPage(
                                        authorUID: authService.currentUser!.uid,
                                        postID: preview.postDataHash,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  FlutterRemix.menu_add_line,
                                  size: 20,
                                  color: theme.textTheme.bodyText1?.color,
                                ),
                                label: Text(
                                  "Add review",
                                  style: theme.textTheme.bodyText2,
                                ),
                              ),
                            )
                        ],
                      ),
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
