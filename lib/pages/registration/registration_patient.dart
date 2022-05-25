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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: theme.textTheme.bodyText1,
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
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(
            "Birth Date",
            style: theme.textTheme.subtitle2?.copyWith(fontSize: 12),
          ),
        ),
        CalendarDatePicker(
          initialCalendarMode: DatePickerMode.year,
          initialDate: DateTime(2004),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          onDateChanged: (DateTime value) {},
        ),
      ],
    );
  }
}
