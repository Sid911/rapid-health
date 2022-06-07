import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/utility/user.dart';

import 'bookings_view/bookings_view.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late AuthServiceInterface authService;
  late PostsServiceInterface postsService;
  late BookingServiceInterface bookingService;

  late User user;

  @override
  void initState() {
    super.initState();
    authService = context.read<AuthServiceInterface>();
    postsService = context.read<PostsServiceInterface>();
    bookingService = context.read<BookingServiceInterface>();
    user = authService.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userData = user.userData;
    String initials = "";
    for (String s in userData.name.split(" ")) {
      initials += s[0];
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Bookings"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IntroCard(
                  initials: initials,
                  theme: theme,
                  currentUser: userData,
                ),
                BookingsView(user: user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    Key? key,
    required this.initials,
    required this.theme,
    required this.currentUser,
  }) : super(key: key);

  final String initials;
  final ThemeData theme;
  final UserData currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: theme.primaryColor,
          child: Text(
            initials,
            style: theme.textTheme.headline2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text.rich(
                TextSpan(
                  text: currentUser.name,
                  children: [
                    TextSpan(
                      text: '\n${currentUser.email}',
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                style: theme.textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
