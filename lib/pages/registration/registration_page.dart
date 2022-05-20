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
  bool isDoctor = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomSheet: BottomSheet(
        enableDrag: false,
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height - (isDoctor ? 200 : 400),
        ),
        onClosing: () {},
        backgroundColor: theme.scaffoldBackgroundColor,
        builder: (context) {
          return Stack(
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
                  backgroundColor:
                      MaterialStateProperty.all(theme.primaryColor),
                ),
                onPressed: () {},
                child: GlowIcon(
                  FlutterRemix.arrow_right_s_line,
                  glowColor: Colors.lightBlueAccent,
                  color: theme.textTheme.headline4?.color,
                ),
              ),
            ],
          );
        },
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
                onChanged: (value) {
                  setState(() {
                    isDoctor = value;
                  });
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
