import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:rapid_health/interfaces/auth_service_interface.dart';
import 'package:rapid_health/services/bookingStorageService/booking_data.dart';
import 'package:rapid_health/services/chatStorageService/chat_data.dart';
import 'package:rapid_health/services/loginService/user_data.dart';
import 'package:rapid_health/services/postStorageService/post_data.dart';
import 'package:rapid_health/services/reviewStorageService/review_data.dart';
import 'package:rapid_health/utility/randomString.dart';

import 'doctor_categories.dart';

class LocalServer {
  static final LocalServer _instance = LocalServer._private();
  static LocalServer get instance => _instance;

  //region Hive Boxes
  static late Box<DoctorData> doctorsBox;
  static late Box<PatientData> patientBox;
  static late Box<Chat> chatsBox;
  static late Box<ChatData> conversationBox;
  static late Box<Posts> postsBox;
  static late Box<PostData> postDataBox;
  static late Box<Reviews> reviewsBox;
  static late Box<BookingData> bookingsBox;
  static late Box<DoctorBookings> docBookings;
  static late Box<PatientBookings> userBookings;
  //endregion

  static final Logger _logger = Logger();

  LocalServer._private();

  static Future<void> init() async {
    // Core auth and general adapters
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(PatientAdapter());
    Hive.registerAdapter(DoctorAdapter());
    Hive.registerAdapter(DoctorCategoriesAdapter());
    // Chat based adapter
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ChatDataAdapter());
    Hive.registerAdapter(ChatPreviewAdapter());
    // Post and review based Adapter
    Hive.registerAdapter(PostPreviewAdapter());
    Hive.registerAdapter(PostsAdapter());
    Hive.registerAdapter(PostDataAdapter());

    Hive.registerAdapter(ReviewDataAdapter());
    Hive.registerAdapter(ReviewsAdapter());

    Hive.registerAdapter(BookingDataAdapter());
    Hive.registerAdapter(TimeOfDayAdapter());
    Hive.registerAdapter(PatientBookingsAdapter());
    Hive.registerAdapter(DoctorBookingsAdapter());

    doctorsBox = await Hive.openBox<DoctorData>("doctors");
    patientBox = await Hive.openBox<PatientData>("patients");
    chatsBox = await Hive.openBox<Chat>("chats");
    conversationBox = await Hive.openBox<ChatData>("conversations");
    postsBox = await Hive.openBox("posts");
    postDataBox = await Hive.openBox("postData");
    reviewsBox = await Hive.openBox("reviews");
    bookingsBox = await Hive.openBox("bookings");
    userBookings = await Hive.openBox("userBookings");
    docBookings = await Hive.openBox("docBookings");

    // bookingsBox.clear();
    // userBookings.clear();
    // docBookings.clear();
    // postsBox.clear();
    // postDataBox.clear();

    // generate Dummy Data
    await generateDummyData();
  }

  static Future<void> generateDummyData() async {
    final now = DateTime.now();
    final sid = PatientData(
      name: 'Siddharth Sinha',
      password: "1a2b3c4d5e",
      email: "siddevs@outlook.com",
      accountCreationDate: now,
      lastLoggedIn: now,
      phone: "0123456789",
      address: "Raipur Chhattisgarh",
      age: 19,
      birthdate: DateTime(2002, 11, 24),
    );
    final sidDoc = DoctorData(
      name: "Siddharth Sinha",
      password: "0123456789",
      email: "siddharthsinha9752@gmail.com",
      accountCreationDate: now,
      lastLoggedIn: now,
      phone: "9876543210",
      workAddress: "Gali 420 Testing Station,Raipur CG",
      workPhone: "5432109876",
      coordinates: List<double>.of([21.260215, 81.633507], growable: false),
      website: "https://sidthedoc.com",
      category: DoctorCategory.physician,
    );
    final examplePost = PostData(
      title: "Nowhere Hospital",
      description:
          "Etiam non lacus ornare, luctus sem in, sollicitudin enim. Morbi lobortis quis mauris ac euismod. "
          "Aenean urna dolor, ultricies tincidunt lacus id, maximus pharetra massa. "
          "Curabitur nec aliquam lacus. Suspendisse sit amet augue feugiat, luctus lorem eget, semper mi. "
          "Curabitur neque nulla, dictum et tortor sit amet, eleifend pharetra elit. Suspendisse mattis dignissim nisl, at tincidunt orci placerat et. "
          "Phasellus non quam augue.",
      subtitle: "To infinity and beyond !",
      postDate: now,
      expireDate: now,
      authorUID: sidDoc.email,
      postCategory: DoctorCategory.emergency,
      coordinates: [34.209515, 77.615112],
      address: "Middle of nowhere, Ladakh, JK, India",
      postHash: "averyrandomhash",
    );
    if (!postsBox.containsKey("siddharthsinha9752@gmail.com")) {
      addPost("siddharthsinha9752@gmail.com", examplePost);
    }
    // Add dummy data for testing
    // patientBox.clear();
    // doctorsBox.clear();
    if (!patientBox.containsKey("siddevs@outlook.com")) {
      patientBox.put("siddevs@outlook.com", sid);
    }
    if (!doctorsBox.containsKey("siddharthsinha9752@gmail.com")) {
      doctorsBox.put("siddharthsinha9752@gmail.com", sidDoc);
    }
  }

  static LoginError loginPatient(String key, String password) {
    final containsUser = patientBox.containsKey(key);
    if (containsUser) {
      final PatientData patient = patientBox.get(key)!;
      if (patient.password == password) {
        patientBox.put(key, patient.copyWith(lastLoggedIn: DateTime.now()));
        return LoginError.success;
      } else {
        return LoginError.incorrectCredential;
      }
    } else {
      return LoginError.notFound;
    }
  }

  static LoginError loginDoctor(String key, String password) {
    final containsUser = doctorsBox.containsKey(key);
    if (containsUser) {
      final DoctorData doctor = doctorsBox.get(key)!;
      if (doctor.password == password) {
        doctorsBox.put(key, doctor.copyWith(lastLoggedIn: DateTime.now()));
        return LoginError.success;
      } else {
        return LoginError.incorrectCredential;
      }
    } else {
      return LoginError.notFound;
    }
  }

  static DoctorData? getDoctorData(String key) {
    return doctorsBox.get(key);
  }

  static PatientData? getPatientData(String key) {
    return patientBox.get(key);
  }

  /// region PostService

  /// Adds post and synchronises PostPreview data
  static Future<void> addPost(String uid, PostData post) async {
    final randomKey = sha1RandomString();
    final finalPost = post.copyWith(postHash: randomKey);
    postDataBox.put(randomKey, finalPost);
    Posts postsObj;
    if (!postsBox.containsKey(uid)) {
      // Create new index for the user
      postsObj = Posts(
        authorUID: uid,
        previews: [
          PostPreview.fromPostData(finalPost),
        ],
      );
      _logger.i(
        "Adding new Post from scratch"
        "\nKey : $randomKey"
        "\nFor AuthorUID : $uid",
      );
    } else {
      postsObj = postsBox.get(uid)!;
      postsObj.previews.add(PostPreview.fromPostData(finalPost));
      _logger.i(
        "Adding new Post to already existing user index"
        "\nKey : $randomKey"
        "\nFor AuthorUID : $uid",
      );
    }
    await postsBox.put(uid, postsObj);
  }

  static Future<void> addReview(String postUID, ReviewData review) async {
    final randomKey = sha1RandomString();
    Reviews reviewsObj;
    if (!reviewsBox.containsKey(postUID)) {
      reviewsObj = Reviews(postUID, [review]);
      _logger.i(
        "Adding new Review from scratch"
        "\nKey : $randomKey"
        "\nFor AuthorUID : ${review.authorUID}",
      );
    } else {
      reviewsObj = reviewsBox.get(postUID)!;
      reviewsObj.reviews.add(review);
      _logger.i(
        "Adding new Review to already existing user index"
        "\nKey : $randomKey"
        "\nFor AuthorUID : ${review.authorUID}",
      );
    }
    await reviewsBox.put(postUID, reviewsObj);
  }

  /// endregion

  /// region Booking Service

  static Future<void> addBooking(String userUID, BookingData data) async {
    final randomKey = sha1RandomString();
    bookingsBox.put(randomKey, data.copyWith(key: randomKey));
    _logger.i("Adding bookingData to Box with key $randomKey");
    // sync with each party's indexes
    // doctor sync
    DoctorBookings docObj;
    if (!docBookings.containsKey(data.doctorUID)) {
      // if doctor doesn't have an index yet make and index
      docObj = DoctorBookings(data.doctorUID, [randomKey]);
      _logger.i("Doctor is new!");
    } else {
      docObj = docBookings.get(data.doctorUID)!;
      docObj.bookingUIDs.add(randomKey);
      _logger.i(
          "Doctor is old! CurrentObject has ${docObj.bookingUIDs.length} ids");
    }
    docBookings.put(docObj.doctorUID, docObj);
    // user sync
    PatientBookings userObj;
    if (!userBookings.containsKey(data.patientUID)) {
      userObj = PatientBookings(data.patientUID, [randomKey]);
      _logger.i("User is new!");
    } else {
      userObj = userBookings.get(data.patientUID)!;
      userObj.bookingUIDs.add(randomKey);
      _logger.i(
          "User is old! CurrentObject has ${userObj.bookingUIDs.length} ids");
    }
    userBookings.put(userObj.patientUID, userObj);
  }

  /// endregion
}
