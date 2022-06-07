import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_health/bloc/registration/registration_cubit.dart';
import 'package:rapid_health/pages/registration/registration_doctor.dart';
import 'package:rapid_health/pages/registration/registration_patient.dart';

class RegistrationCard extends StatefulWidget {
  const RegistrationCard({Key? key}) : super(key: key);

  @override
  State<RegistrationCard> createState() => _RegistrationCardState();
}

class _RegistrationCardState extends State<RegistrationCard> {
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
                final isDoctor = state is RegistrationDoctor;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Enter the details for ${isDoctor ? "Doctors" : "Normal"} account",
                    style: theme.textTheme.bodyText1,
                  ),
                );
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              style: theme.textTheme.bodyText1,
              decoration: const InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(fontSize: 12),
              ),
              onChanged: (value) {
                context.read<RegistrationCubit>().setName(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the full name';
                }
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              style: theme.textTheme.bodyText1,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 12),
              ),
              onChanged: (value) {
                context.read<RegistrationCubit>().setEmail(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              style: theme.textTheme.bodyText1,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 12),
              ),
              onChanged: (value) {
                context.read<RegistrationCubit>().setPassword(value);
              },
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Please enter 8 digit password';
                }
                return null;
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              style: theme.textTheme.bodyText1,
              decoration: const InputDecoration(
                labelText: "Phone no.",
                labelStyle: TextStyle(fontSize: 12),
              ),
              onChanged: (value) {
                context.read<RegistrationCubit>().setPhone(value);
              },
              validator: (value) {
                if (value == null || value.length < 10) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
            ),
            BlocBuilder<RegistrationCubit, RegistrationState>(
              builder: (context, state) {
                if (state is RegistrationPatient) {
                  return const PatientRegistration();
                }
                return const DoctorRegistration();
              },
            )
          ],
        ),
      ),
    );
  }
}
