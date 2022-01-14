import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class HomeStore extends ValueNotifier<bool> {
  String previousHash = "a9860916d3b24efd7ff36d527277fc8411bf1183";

  HomeStore() : super(false);

  Future<bool> siteIsChanged() async {
    try {
      Response response = await get(
        Uri.parse(
            "https://masterclass.flutterando.com.br/public/products/8f64d9b5-e1fb-4cf0-86a0-2e04c4580a5b"),
      );

      if (response.statusCode == 200) {
        bool isEqual = hashCompare(body: response.body);

        if (isEqual) {
          return false;
        } else {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  bool hashCompare({required String body}) {
    List<int> bytes = utf8.encode(body);

    String sha = sha1.convert(bytes).toString();

    print(sha.toString());

    if (sha == previousHash) {
      return false;
    }

    return true;
  }
}
