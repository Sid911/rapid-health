import 'package:flutter/material.dart';

import '../utility/doctor_categories.dart';

class DoctorDropdownButton extends StatelessWidget {
  const DoctorDropdownButton(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);
  final DoctorCategory value;
  final void Function(DoctorCategory selected) onChanged;

  List<DropdownMenuItem<DoctorCategory>> get dropdownItems {
    List<DropdownMenuItem<DoctorCategory>> menuItems = [
      const DropdownMenuItem(
          child: Text("Emergency"), value: DoctorCategory.emergency),
      const DropdownMenuItem(
          child: Text("Physician"), value: DoctorCategory.physician),
      const DropdownMenuItem(
          child: Text("Orthopaedic"), value: DoctorCategory.orthopaedic),
      const DropdownMenuItem(
          child: Text("Gynecologist"), value: DoctorCategory.gynecologist),
      const DropdownMenuItem(
          child: Text("Dentist"), value: DoctorCategory.dentist),
      const DropdownMenuItem(child: Text("ENT"), value: DoctorCategory.ent),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButton<DoctorCategory>(
      value: value,
      style: theme.textTheme.bodyText1,
      items: dropdownItems,
      onChanged: (value) {
        value ??= DoctorCategory.emergency;
        onChanged(value);
      },
    );
  }
}
