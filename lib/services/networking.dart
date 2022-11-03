import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url); //Constructor.

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //If there is no problem.
      String data = response.body;

      return jsonDecode(data); //Decode the information.
    } else {
      //If a problem happened while getting information.
      print(response.statusCode); //Print the error code.
    }
  }
}
