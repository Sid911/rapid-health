import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'booking_data.g.dart';

///
@HiveType(typeId: 11, adapterName: "BookingDataAdapter")
class BookingData {
  @HiveField(0)
  final String patientUID;

  @HiveField(1)
  final String doctorUID;

  /// copy of key for the booking data
  @HiveField(2)
  final String key;

  ///
  @HiveField(3)
  final DateTime bookingDate;

  ///
  @HiveField(4)
  final bool isValid;

  ///
  @HiveField(5)
  final String postUID;

  @HiveField(6)
  final TimeOfDay time;

  BookingData({
    required this.patientUID,
    required this.doctorUID,
    required this.key,
    required this.bookingDate,
    required this.isValid,
    required this.postUID,
    required this.time,
  });

  ///
  BookingData copyWith({
    String? patientUID,
    String? doctorUID,
    String? key,
    DateTime? bookingDate,
    bool? isValid,
    String? postUID,
    TimeOfDay? time,
  }) {
    return BookingData(
      patientUID: patientUID ?? this.patientUID,
      doctorUID: doctorUID ?? this.doctorUID,
      key: key ?? this.key,
      bookingDate: bookingDate ?? this.bookingDate,
      isValid: isValid ?? this.isValid,
      postUID: postUID ?? this.postUID,
      time: time ?? this.time,
    );
  }
}

/// Patients booking data
@HiveType(typeId: 12, adapterName: "PatientBookingsAdapter")
class PatientBookings {
  @HiveField(0)
  final String patientUID;

  /// UIDs of [BookingData]
  @HiveField(1)
  final List<String> bookingUIDs;

  PatientBookings(this.patientUID, this.bookingUIDs);
}

/// Doctor Bookings data
@HiveType(typeId: 13, adapterName: "DoctorBookingsAdapter")
class DoctorBookings {
  /// String uid of doctor
  @HiveField(0)
  final String doctorUID;

  /// UIDs of [BookingData]
  @HiveField(1)
  final List<String> bookingUIDs;

  DoctorBookings(this.doctorUID, this.bookingUIDs);
}
