import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_health/global/post_header.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';

class BookingEditorPage extends StatefulWidget {
  const BookingEditorPage({Key? key, required this.data}) : super(key: key);
  final PostData data;
  @override
  State<BookingEditorPage> createState() => _BookingEditorPageState();
}

class _BookingEditorPageState extends State<BookingEditorPage> {
  late BookingServiceInterface bookingService;
  late AuthServiceInterface authService;
  late PostData postData;
  DateTime currentDate = DateTime.now().add(const Duration(days: 3));

  TimeOfDay currentTime = const TimeOfDay(hour: 16, minute: 0);

  @override
  void initState() {
    super.initState();
    bookingService = context.read<BookingServiceInterface>();
    authService = context.read<AuthServiceInterface>();
    postData = widget.data;
  }

  void _showDateDialog(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1920),
      lastDate: DateTime(2050),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  void _showTimeDialog(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    if (pickedTime != null) {
      currentTime = pickedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final darkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Page"),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              PostHeader(postData: PostPreview.fromPostData(widget.data)),
              Image.asset("assets/1x/dataArrange.png"),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: darkMode
                      ? Colors.blueGrey.shade700
                      : Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Preferred date",
                        style: theme.textTheme.bodyText1,
                      ),
                      trailing: Text(
                        currentDate.toIso8601String().substring(0, 10),
                      ),
                      onTap: () {
                        // show DateTime Dialog
                        _showDateDialog(context);
                      },
                    ),
                    ListTile(
                      title: Text(
                        "Preferred time",
                        style: theme.textTheme.bodyText1,
                      ),
                      trailing: Text(
                        currentTime.toString(),
                      ),
                      onTap: () {
                        // show DateTime Dialog
                        _showTimeDialog(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final data = BookingData(
                                patientUID:
                                    authService.currentUser!.parsedUID.id,
                                doctorUID: postData.authorUID,
                                key: "",
                                bookingDate: currentDate,
                                isValid: true,
                                postUID: postData.postHash,
                                time: currentTime,
                              );
                              bookingService.addNewBooking(
                                  data.patientUID, data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Booking Successful! Please wait for the Service Provider to confirm",
                                  ),
                                ),
                              );
                            },
                            child: const Text("Continue"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
