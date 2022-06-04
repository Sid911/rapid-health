import 'package:rapid_health/utility/user.dart';

import '../services/bookingStorageService/booking_data.dart';

abstract class BookingServiceInterface {
  void addNewBooking(String authorUID, BookingData data);
  void cancelBooking(String uid);
  PatientBookings? getPatientBookings(String patientUID);
  DoctorBookings? getDoctorBookings(String doctorUID);
  Future<List<BookingData>> getBookingsForUser(UserUID uUID);
}
