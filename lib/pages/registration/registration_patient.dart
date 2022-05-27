import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_health/bloc/registration/registration_cubit.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({Key? key}) : super(key: key);

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: theme.textTheme.bodyText1,
          maxLines: 2,
          onChanged: (value) {
            context.read<RegistrationCubit>().setPatientAddress(value);
          },
          decoration: const InputDecoration(
            labelText: "Address",
            labelStyle: TextStyle(fontSize: 12),
          ),
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Please enter an elaborate address';
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
          onDateChanged: (DateTime value) {
            final cubit = context.read<RegistrationCubit>();
            cubit.setPatientBirthDate(value);
            cubit.setPatientAge(DateTime.now().year - value.year);
          },
        ),
      ],
    );
  }
}
