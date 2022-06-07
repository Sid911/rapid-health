import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/global/chips.dart';
import 'package:rapid_health/global/loading_wrapper.dart';
import 'package:rapid_health/global/not_found_wrapper.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';
import 'package:rapid_health/utility/user.dart';

class UserBookingsView extends StatefulWidget {
  const UserBookingsView({Key? key}) : super(key: key);

  @override
  State<UserBookingsView> createState() => _UserBookingsViewState();
}

class _UserBookingsViewState extends State<UserBookingsView> {
  late AuthServiceInterface authService;
  late BookingServiceInterface bookingService;
  late PostsServiceInterface postsService;

  late User user;
  @override
  void initState() {
    super.initState();
    authService = context.read<AuthServiceInterface>();
    bookingService = context.read<BookingServiceInterface>();
    postsService = context.read<PostsServiceInterface>();

    user = authService.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingData>>(
      future: bookingService.getBookingsForUser(user.parsedUID),
      builder: (context, snap) {
        if (snap.hasData) {
          final data = snap.data!;
          if (data.isEmpty) {
            return const NotFoundWrapper(text: "No bookings found");
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return UserBookingTile(
                postsService: postsService,
                bookingData: data[index],
              );
            },
          );
        }
        return const LoadingWrapper();
      },
    );
  }
}

class UserBookingTile extends StatelessWidget {
  const UserBookingTile({
    Key? key,
    this.bookingData,
    required this.postsService,
  }) : super(key: key);
  final BookingData? bookingData;
  final PostsServiceInterface postsService;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<PostData?>(
      future: postsService.getPostData(bookingData?.postUID ?? "random"),
      builder: (context, snap) {
        final data = snap.data;
        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snap.hasData ? data!.title : "Title of the Appointment",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  snap.hasData ? data!.address : "Address of the Appointment",
                  style: theme.textTheme.bodyText1,
                ),
              )
            ],
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
        );
      },
    );
  }
}
