import 'package:flutter/material.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: "Work phone no. (public)",
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
          keyboardType: TextInputType.streetAddress,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Work address (public)",
            labelStyle: TextStyle(fontSize: 12),
          ),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Please enter elaborate address';
            }
            return null;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.streetAddress,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Website",
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
    );
  }
}
