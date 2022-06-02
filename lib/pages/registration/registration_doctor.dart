import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_health/global/doctor_dropdown_button.dart';

import '../../bloc/registration/registration_cubit.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
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
                    return DoctorDropdownButton(
                      value: state.category,
                      onChanged: (category) {
                        context
                            .read<RegistrationCubit>()
                            .setDoctorWorkCategory(category);
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
