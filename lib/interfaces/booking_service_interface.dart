import '../services/bookingStorageService/booking_data.dart';

abstract class BookingServiceInterface {
  void addNewBooking(BookingData data);
  void cancelBooking(String uid);
  PatientBookings getPatientBookings(String patientUID);
  DoctorBookings getDoctorBookings(String doctorUID);
}
