import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/chips.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';

class BookingsMini extends StatefulWidget {
  const BookingsMini({Key? key}) : super(key: key);

  @override
  State<BookingsMini> createState() => BookingsMiniState();
}

class BookingsMiniState extends State<BookingsMini> {
  late BookingServiceInterface bookingService;
  late AuthServiceInterface authService;
  late PostsServiceInterface postsService;
  final _listState = GlobalKey<AnimatedListState>(debugLabel: "BookingsMini");
  final List<BookingData> currentBookings = List.empty(growable: true);
  bool noBookings = true;
  int index = 0;

  @override
  void initState() {
    super.initState();
    bookingService = context.read<BookingServiceInterface>();
    authService = context.read<AuthServiceInterface>();
    postsService = context.read<PostsServiceInterface>();
    _loadBookings();
  }

  void _loadBookings() async {
    while (index > 0) {
      _listState.currentState!.removeItem(
        0,
        (context, animation) => BookingTile(
            animation: animation,
            bookingData: null,
            postsService: postsService),
      );
      await Future.delayed(const Duration(seconds: 1));
      index--;
    }
    currentBookings.clear();
    final bookings = await bookingService
        .getBookingsForUser(authService.currentUser!.parsedUID);
    if (bookings.isNotEmpty) {
      setState(() {
        noBookings = false;
      });
    }
    for (BookingData b in bookings) {
      if (index > 2) {
        break;
      }
      if (b.isValid) {
        currentBookings.add(b);
        _listState.currentState!
            .insertItem(index, duration: const Duration(milliseconds: 500));
        await Future.delayed(const Duration(seconds: 1));
        index++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bookings",
                  style: theme.textTheme.headline4,
                ),
                IconButton(
                  onPressed: () {
                    _loadBookings();
                  },
                  icon: const Icon(FlutterRemix.refresh_line),
                ),
              ],
            ),
          ),
          if (noBookings)
            const NotFoundWrapper(
              text: "No Bookings Found",
              height: 200,
            ),
          AnimatedList(
            key: _listState,
            shrinkWrap: true,
            initialItemCount: 0,
            itemBuilder: (
              BuildContext context,
              int index,
              Animation<double> animation,
            ) {
              return BookingTile(
                animation: animation,
                bookingData: currentBookings[index],
                postsService: postsService,
              );
            },
          )
        ],
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  const BookingTile({
    Key? key,
    required this.animation,
    required this.bookingData,
    required this.postsService,
  }) : super(key: key);
  final Animation<double> animation;
  final BookingData? bookingData;
  final PostsServiceInterface postsService;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<PostData?>(
      future: postsService.getPostData(bookingData?.postUID ?? "random"),
      builder: (context, snap) {
        final data = snap.data;
        return FadeTransition(
          opacity: animation,
          child: ListTile(
            title: Text(
              snap.hasData ? data!.title : "Tittle of the Appointment",
              style: theme.textTheme.bodyText1,
            ),
            subtitle: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomChip(
                    child: Text(
                      (snap.hasData
                              ? data!.postCategory
                              : DoctorCategory.emergency)
                          .getString(),
                    ),
                  ),
                  if (bookingData != null)
                    Text(
                        "${bookingData?.bookingDate.toIso8601String().substring(0, 10)}     "
                        "${bookingData?.time.format(context)}"),
                ],
              ),
            ),
            isThreeLine: true,
            trailing: const Icon(FlutterRemix.arrow_right_s_line),
          ),
        );
      },
    );
  }
}
