import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:rapid_health/pages/registration/registration_doctor.dart';
import 'package:rapid_health/pages/registration/registration_patient.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> marginAnimation;
  bool isDoctor = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 1000,
        ));

    marginAnimation = Tween<double>(begin: 400, end: 200).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo,
      ),
    );
  }

  void _startAnimation() {
    _controller.forward().orCancel;
  }

  void _reverseAnimation() {
    _controller.reverse().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomSheet: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final newheight = height - marginAnimation.value;
          return BottomSheet(
            enableDrag: false,
            constraints: BoxConstraints(
              maxHeight: newheight,
            ),
            onClosing: () {},
            backgroundColor: theme.scaffoldBackgroundColor,
            builder: (context) {
              return child!;
            },
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: isDoctor
                  ? const DoctorRegistration()
                  : const PatientRegistration(),
            ),
            OutlinedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return 10;
                  } else if (states.contains(MaterialState.pressed)) {
                    return 5;
                  }
                  return 15;
                }),
                backgroundColor: MaterialStateProperty.all(theme.primaryColor),
              ),
              onPressed: () {},
              child: GlowIcon(
                FlutterRemix.arrow_right_s_line,
                glowColor: Colors.lightBlueAccent,
                color: theme.textTheme.headline4?.color,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Quick !",
                style: theme.textTheme.headline2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                "Lets get you registered",
                style: theme.textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: SwitchListTile(
                value: isDoctor,
                onChanged: (value) async {
                  setState(() {
                    isDoctor = value;
                  });
                  await Future.delayed(const Duration(milliseconds: 500));
                  if (value) {
                    _startAnimation();
                  } else {
                    _reverseAnimation();
                  }
                },
                title: Text(
                  "Are you a doctor ?",
                  style: theme.textTheme.bodyText1,
                ),
                subtitle: const Text("Indenting to give service?"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
