import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/registration/registration_cubit.dart';
import '../../utility/doctor_categories.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  List<DropdownMenuItem<DoctorCategory>> get dropdownItems {
    List<DropdownMenuItem<DoctorCategory>> menuItems = [
      const DropdownMenuItem(
          child: Text("Emergency"), value: DoctorCategory.emergency),
      const DropdownMenuItem(
          child: Text("Physician"), value: DoctorCategory.physician),
      const DropdownMenuItem(
          child: Text("Orthopaedic"), value: DoctorCategory.orthopaedic),
      const DropdownMenuItem(
          child: Text("England"), value: DoctorCategory.gynecologist),
      const DropdownMenuItem(
          child: Text("Dentist"), value: DoctorCategory.dentist),
      const DropdownMenuItem(child: Text("ENT"), value: DoctorCategory.ent),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          keyboardType: TextInputType.phone,
          style: theme.textTheme.bodyText1,
          decoration: const InputDecoration(
            labelText: "Work phone no. (public)",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkPhone(value);
          },
          validator: (value) {
            if (value == null || value.length < 10) {
              return 'Please enter valid phone number';
            }
            return null;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.streetAddress,
          style: theme.textTheme.bodyText1,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Work address (public)",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkAddress(value);
          },
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Please enter elaborate address';
            }
            return null;
          },
        ),
        TextFormField(
          keyboardType: TextInputType.url,
          style: theme.textTheme.bodyText1,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Website",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkWebsite(value);
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Major type of service you provide"),
              BlocBuilder<RegistrationCubit, RegistrationState>(
                builder: (context, state) {
                  if (state is RegistrationDoctor) {
                    return DropdownButton<DoctorCategory>(
                      value: state.category,
                      style: theme.textTheme.bodyText1,
                      items: dropdownItems,
                      onChanged: (value) {
                        value ??= DoctorCategory.emergency;
                        context
                            .read<RegistrationCubit>()
                            .setDoctorWorkCategory(value);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
