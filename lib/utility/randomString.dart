import 'dart:math';
import 'dart:convert';

import 'package:crypto/crypto.dart';

// md5 hashing a random number
String md5RandomString() {
  final randomNumber = Random().nextDouble();
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = md5.convert(randomBytes).toString();
  return randomString;
}

// sha1 hashing a random number
String sha1RandomString() {
  final randomNumber = Random().nextDouble();
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = sha1.convert(randomBytes).toString();
  return randomString;
}
