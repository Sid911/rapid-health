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
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/utility/doctor_categories.dart';
import 'package:rapid_health/utility/user.dart';

class DoctorBookingsView extends StatefulWidget {
  const DoctorBookingsView({Key? key}) : super(key: key);

  @override
  State<DoctorBookingsView> createState() => _DoctorBookingsViewState();
}

class _DoctorBookingsViewState extends State<DoctorBookingsView> {
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
              return DoctorBookingTile(
                postsService: postsService,
                bookingData: data[index],
                authService: authService,
              );
            },
          );
        }
        return const LoadingWrapper();
      },
    );
  }
}

class DoctorBookingTile extends StatelessWidget {
  const DoctorBookingTile({
    Key? key,
    required this.bookingData,
    required this.postsService,
    required this.authService,
  }) : super(key: key);
  final BookingData bookingData;
  final PostsServiceInterface postsService;
  final AuthServiceInterface authService;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<PostData?>(
      future: postsService.getPostData(bookingData.postUID),
      builder: (context, postSnap) {
        final post = postSnap.data;
        return FutureBuilder<PatientData?>(
          future: authService.getPatientData(bookingData.patientUID),
          builder: (context, userSnap) {
            final patient = userSnap.data;
            return ListTile(
              onTap: () {},
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      userSnap.hasData ? patient!.name : "Name of Patient",
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      userSnap.hasData ? patient!.email : "Name of Patient",
                      style: theme.textTheme.bodyText2,
                    ),
                  ),
                  Text(
                    postSnap.hasData ? post!.title : "Title of the Appointment",
                    style: theme.textTheme.bodyText2,
                  ),
                ],
              ),
              subtitle: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChip(
                      child: Text(
                        (postSnap.hasData
                                ? post!.postCategory
                                : DoctorCategory.emergency)
                            .getString(),
                      ),
                    ),
                    Text(
                        "${bookingData.bookingDate.toIso8601String().substring(0, 10)}     "
                        "${bookingData.time.format(context)}"),
                  ],
                ),
              ),
              isThreeLine: true,
              trailing: const Icon(FlutterRemix.arrow_right_s_line),
            );
          },
        );
      },
    );
  }
}
