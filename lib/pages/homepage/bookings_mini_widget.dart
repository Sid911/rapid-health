import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class BookingsMini extends StatelessWidget {
  const BookingsMini({Key? key}) : super(key: key);

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
            child: Text(
              "Bookings",
              style: theme.textTheme.headline4,
            ),
          ),
          AnimatedList(
            shrinkWrap: true,
            initialItemCount: 3,
            itemBuilder: (
              BuildContext context,
              int index,
              Animation<double> animation,
            ) {
              return BookingTile(animation: animation);
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
  }) : super(key: key);
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      transform: Matrix4.translationValues(1 - animation.value, 0, 0),
      child: ListTile(
        title: Text(
          "Tittle of the Appointment",
          style: theme.textTheme.bodyText2,
        ),
        subtitle: const Text("Category of appointment \nDate of Appointment"),
        dense: true,
        isThreeLine: true,
        trailing: const Icon(FlutterRemix.arrow_right_s_line),
      ),
    );
  }
}
