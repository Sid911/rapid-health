import 'package:flutter/material.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "Enter the details for normal account",
                style: theme.textTheme.bodyText1,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the full name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Please enter 8 digit password';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Phone no.",
                labelStyle: TextStyle(fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.length < 10) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Address",
                labelStyle: TextStyle(fontSize: 12),
              ),
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Please enter elaborate address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
