import 'package:flutter/material.dart';
import 'package:rapid_health/utility/user.dart';

import 'doctor_bookings_view.dart';
import 'user_bookings_view.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: theme.primaryColor, borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: user.isUserDoctor
          ? const DoctorBookingsView()
          : const UserBookingsView(),
    );
  }
}
