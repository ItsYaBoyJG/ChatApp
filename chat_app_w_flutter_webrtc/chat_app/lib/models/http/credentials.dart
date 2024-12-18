import 'dart:convert';
import 'dart:io';

class Credentials {
  Future<Map> getTurnCredential(String host, int port) async {
    HttpClient client = HttpClient(context: SecurityContext());
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
      return true;
    };
    var url =
        'https://$host:$port/api/turn?service=turn&username=flutter-webrtc';
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(const Utf8Decoder()).join();
    Map data = const JsonDecoder().convert(responseBody);
    return data;
  }
}
