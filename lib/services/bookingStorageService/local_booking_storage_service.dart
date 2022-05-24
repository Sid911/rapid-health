import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';

class LocalBookingService extends BookingServiceInterface {
  @override
  void addNewBooking(BookingData data) {
    // TODO: implement addNewBooking
  }

  @override
  void cancelBooking(String uid) {
    // TODO: implement cancelBooking
  }

  @override
  DoctorBookings getDoctorBookings(String doctorUID) {
    // TODO: implement getDoctorBookings
    throw UnimplementedError();
  }

  @override
  PatientBookings getPatientBookings(String patientUID) {
    // TODO: implement getPatientBookings
    throw UnimplementedError();
  }
}
