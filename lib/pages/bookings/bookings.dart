import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';
import 'package:rapid_health/services/loginService/user_data.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  late AuthServiceInterface authService;
  late PostsServiceInterface postsService;
  late BookingServiceInterface bookingService;
  @override
  void initState() {
    super.initState();
    authService = context.read<AuthServiceInterface>();
    postsService = context.read<PostsServiceInterface>();
    bookingService = context.read<BookingServiceInterface>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUser = authService.currentUser!.userData;
    String initials = "";
    for (String s in currentUser.name.split(" ")) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _IntroCard(initials: initials, theme: theme, currentUser: currentUser),
            ],
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
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: Text(
            initials,
            style: theme.textTheme.headline2,
          ),
          backgroundColor: theme.primaryColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text.rich(
                TextSpan(
                  text: currentUser.name,
                  children: [
                    TextSpan(
                      text: '\n' + currentUser.email,
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
