import 'package:hive_flutter/adapters.dart';

part 'booking_data.g.dart';

@HiveType(typeId: 11, adapterName: "BookingDataAdapter")
class BookingData {
  @HiveField(0)
  final String patientUID;
  @HiveField(1)
  final String doctorUID;
  @HiveField(2)
  final String key;
  @HiveField(3)
  final DateTime bookingDate;
  @HiveField(4)
  final bool isValid;
  @HiveField(5)
  final String postUID;

  BookingData({
    required this.patientUID,
    required this.doctorUID,
    required this.key,
    required this.bookingDate,
    required this.isValid,
    required this.postUID,
  });

  BookingData copyWith({
    String? patientUID,
    String? doctorUID,
    String? key,
    DateTime? bookingDate,
    bool? isValid,
    String? postUID,
  }) {
    return BookingData(
      patientUID: patientUID ?? this.patientUID,
      doctorUID: doctorUID ?? this.doctorUID,
      key: key ?? this.key,
      bookingDate: bookingDate ?? this.bookingDate,
      isValid: isValid ?? this.isValid,
      postUID: postUID ?? this.postUID,
    );
  }
}

@HiveType(typeId: 12, adapterName: "PatientBookingsAdapter")
class PatientBookings {
  @HiveField(0)
  final String patientUID;

  /// UIDs of [BookingData]
  @HiveField(1)
  final List<String> bookingUIDs;

  PatientBookings(this.patientUID, this.bookingUIDs);
}

@HiveType(typeId: 13, adapterName: "DoctorBookingsAdapter")
class DoctorBookings {
  @HiveField(0)
  final String doctorUID;

  /// UIDs of [BookingData]
  @HiveField(1)
  final List<String> bookingUIDs;

  DoctorBookings(this.doctorUID, this.bookingUIDs);
}
