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
    Hive.registerAdapter(ChatMessageAdapter());
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

    // chatsBox.clear();
    // conversationBox.clear();
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
      name: 'Guest Patient',
      password: "guest",
      email: "guestpatient@dev.com",
      accountCreationDate: now,
      lastLoggedIn: now,
      phone: "0123456789",
      address: "Raipur Chhattisgarh",
      age: 19,
      birthdate: DateTime(2002, 11, 24),
    );
    final sidDoc = DoctorData(
      name: "Dr. Guest",
      password: "guest",
      email: "guestdoctor@dev.com",
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

    final List<ChatMessage> randomMessages = [
      ChatMessage(
        sid.uid,
        sidDoc.uid,
        now,
        "Hi Guest Doc, a huge coincidence on our name huh?",
      ),
      ChatMessage(
        sid.uid,
        sidDoc.uid,
        now,
        "I was just thinking about sending this after seeing your name",
      ),
      ChatMessage(
        sidDoc.uid,
        sid.uid,
        now,
        "HI, random \"random guest\" from the internet, nice to know you people"
        "still exist in this world",
      ),
      ChatMessage(
        sidDoc.uid,
        sid.uid,
        now,
        "Humpty Dumpty was a common ???nickname???, used in 15th century England, to describe large people. "
        "This had led to many ideas as to who, or what, the Humpty Dumpty in the nursery rhyme really was. "
        "The idea that ???Humpty Dumpty??? was a powerful cannon, "
        "used during the English Civil War (1642-49), is one of the ideas taken most seriously.",
      ),
    ];

    const hash = "myRandomHash";
    if (!conversationBox.containsKey(hash)) {
      await addMessage(randomMessages[0], hash);
      await addMessage(randomMessages[1], hash);
      await addMessage(randomMessages[2], hash);
      await addMessage(randomMessages[3], hash);
    }

    if (!postsBox.containsKey("guestdoctor@dev.com")) {
      addPost("guestdoctor@dev.com", examplePost);
    }
    // Add dummy data for testing
    // patientBox.clear();
    // doctorsBox.clear();
    if (!patientBox.containsKey("guestpatient@dev.com")) {
      patientBox.put("guestpatient@dev.com", sid);
    }
    if (!doctorsBox.containsKey("guestdoctor@dev.com")) {
      doctorsBox.put("guestdoctor@dev.com", sidDoc);
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
    // Use the time now to add to Hive box
    // This causes the keys to stay in relevant order and allow to query for time
    final randomKey = DateTime.now().toIso8601String();
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
  /// region Chat Service

  static Future<void> addNewConversation(
    ChatData initialData,
  ) async {
    // check if the sender has any chat index
    if (!chatsBox.containsKey(initialData.originID)) {
      // create a new index
      await chatsBox.put(
        initialData.originID,
        Chat([], initialData.originID),
      );
    }
    if (!chatsBox.containsKey(initialData.targetID)) {
      await chatsBox.put(
        initialData.targetID,
        Chat([], initialData.targetID),
      );
    }
  }

  static Future<void> updatePreviews(ChatData data) async {
    final originChat = chatsBox.get(data.originID)!;
    originChat.chats.removeWhere((element) => element.chatHash == data.hashKey);
    originChat.chats.add(data.toChatPreview(false));
    await chatsBox.put(data.originID, originChat);

    final targetChat = chatsBox.get(data.targetID)!;
    targetChat.chats.removeWhere((element) => element.chatHash == data.hashKey);
    targetChat.chats.add(data.toChatPreview(true));
    await chatsBox.put(data.targetID, targetChat);
  }

  static Future<String> addMessage(
    ChatMessage message,
    String? conversationHash,
  ) async {
    final randomKey = sha1RandomString();
    ChatData data;
    if (conversationHash == null) {
      // new conversation
      _logger.i("Making a new Conversation with key : $randomKey");
      data = ChatData(
        message.receiverID,
        message.senderID,
        randomKey,
        [message],
      );
      await addNewConversation(data);
    } else if (!conversationBox.containsKey(conversationHash)) {
      _logger.wtf(
        "The conversation hash $conversationHash doesn't exist in the box"
        "\nCreating new conversation with same hash as key",
      );
      data = ChatData(
        message.receiverID,
        message.senderID,
        conversationHash,
        [message],
      );
      await addNewConversation(data);
    } else {
      _logger.i("Conversation $conversationHash exists! adding message to it");
      data = conversationBox.get(conversationHash)!;
      data.messages.add(message);
    }
    // retrieve index
    await updatePreviews(data);

    await conversationBox.put(data.hashKey, data);
    return data.hashKey;
  }
}
