import 'package:rapid_health/interfaces/booking_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';
import 'package:rapid_health/utility/local_server.dart';
import 'package:rapid_health/utility/user.dart';

class LocalBookingService extends BookingServiceInterface {
  @override
  void addNewBooking(String authorUID, BookingData data) {
    LocalServer.addBooking(authorUID, data);
  }

  @override
  void cancelBooking(String uid) {
    // TODO: implement cancelBooking
  }

  @override
  DoctorBookings? getDoctorBookings(String doctorUID) {
    return LocalServer.docBookings.get(doctorUID);
  }

  @override
  PatientBookings? getPatientBookings(String patientUID) {
    return LocalServer.userBookings.get(patientUID);
  }

  @override
  Future<List<BookingData>> getBookingsForUser(UserUID uUID) async {
    final List<BookingData> _list = List.empty(growable: true);
    List<String> bookingHashes = List.empty();
    if (uUID.isDoctor) {
      if (LocalServer.docBookings.containsKey(uUID.id))
        bookingHashes = getDoctorBookings(uUID.id)!.bookingUIDs;
    } else {
      if (LocalServer.userBookings.containsKey(uUID.id))
        bookingHashes = getPatientBookings(uUID.id)!.bookingUIDs;
    }
    for (String hash in bookingHashes) {
      if (LocalServer.bookingsBox.containsKey(hash))
        _list.add(LocalServer.bookingsBox.get(hash)!);
    }
    return _list;
  }
}
