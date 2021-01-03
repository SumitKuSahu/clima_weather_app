import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkingData
{
  NetworkingData(this.url);
final url;

  Future<dynamic> getApi()
  async {
    http.Response response = await http.get(url);
    String body = response.body;
    if (response.statusCode == 200) {
      var decoder=jsonDecode(body);
     return decoder;
    }
    else
      print(response.statusCode);
  }
}