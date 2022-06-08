import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/pages/post_view/reviews_widget.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';

import '../../utility/user.dart';

class ProfilePatientReviews extends StatefulWidget {
  const ProfilePatientReviews({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<ProfilePatientReviews> createState() => _ProfilePatientReviewsState();
}

class _ProfilePatientReviewsState extends State<ProfilePatientReviews> {
  late User user;

  late PostsServiceInterface postsService;
  late BookingServiceInterface bookingService;
  bool noReviewsFound = false;

  final _listState =
      GlobalKey<AnimatedListState>(debugLabel: "Patient Reviews");
  final List<ReviewData> reviews = List.empty(growable: true);
  final List<UserUID> uIDs = List.empty(growable: true);

  Future<void> _getReviews() async {
    final bookings = await bookingService.getBookingsForUser(user.parsedUID);
    for (final booking in bookings) {
      final localReviews =
          await postsService.getReviewsForPost(booking.postUID);
      if (localReviews == null) {
        setState(() {
          noReviewsFound = true;
        });
        return;
      }
      int index = 0;
      for (var element in localReviews.reviews) {
        if (element.authorUID == user.uid) {
          reviews.add(element);
          uIDs.add(UserUID.fromString(element.authorUID));
          _listState.currentState!.insertItem(index);
          await Future.delayed(const Duration(milliseconds: 200));
          index++;
        }
      }
      if (reviews.isEmpty) {
        setState(() {
          noReviewsFound = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;

    postsService = context.read<PostsServiceInterface>();
    bookingService = context.read<BookingServiceInterface>();
    _getReviews();
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
            "Reviews :",
            style: theme.textTheme.headline4,
          ),
        ),
        if (noReviewsFound) const NotFoundWrapper(text: "No Reviews Found"),
        AnimatedList(
          shrinkWrap: true,
          key: _listState,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: ReviewTile(
                data: reviews[index],
                uid: uIDs[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
