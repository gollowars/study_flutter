import 'dart:convert';
import 'package:netroll/constants.dart';
import 'package:netroll/models/user.dart';
import 'package:netroll/providers/api_provider.dart';
import 'package:http/http.dart' as http;

class UsersRepository {
  fetch() async {
    final http.Response _response = await UserProvier().fetch(ENDPOINT);
    if (_response.statusCode == 200) {
      final _decodeResponse = await json.decode(_response.body);
      return UserResponse.fromJson(_decodeResponse);
    } else {
      throw Exception("Error");
    }
  }
}
