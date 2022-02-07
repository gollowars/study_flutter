import 'package:http/http.dart' as http;

class UserProvier {
  Future<http.Response> fetch(String _url) async {
    final _response = await http.get(Uri.parse(_url));
    return _response;
  }
}
