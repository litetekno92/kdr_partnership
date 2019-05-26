import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AREST {
  static Future<void> httpsGetRequest({@required String path, Map<String, String> header, @required Function onSuccess, @required Function onError}) async {
    if (!header.containsKey("Accept"))
      header["Accept"] = "application/json";
    final response = await http.get(Uri.encodeFull(path), headers: header);
    if (response.statusCode == 200) {
      onSuccess(response.body);
    }
    else {
      onError(response.body);
    }
  }
}
