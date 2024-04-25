import 'package:flutter/material.dart';

class CipherData {
  final String name;
  final String image;
  final String ciphertext;
  final dynamic key;
  String url;
  final dynamic Function(String, String) decryptionFunction;

  CipherData(
      {required this.name,
      required this.ciphertext,
      required this.key,
      required this.decryptionFunction,
      required this.image,
      required this.url});
}
