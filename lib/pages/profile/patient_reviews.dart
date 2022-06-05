import 'package:flutter/material.dart';
import 'package:rapid_health/interfaces/posts_service_interface.dart';

class ProfilePatientReviews extends StatefulWidget {
  const ProfilePatientReviews({Key? key}) : super(key: key);

  @override
  State<ProfilePatientReviews> createState() => _ProfilePatientReviewsState();
}

class _ProfilePatientReviewsState extends State<ProfilePatientReviews> {
  late PostsServiceInterface postsService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
