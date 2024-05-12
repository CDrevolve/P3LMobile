import 'dart:convert';
import 'package:http/http.dart';
import 'package:p3lmobile/model/presensi.dart';

class PresensiClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/presensiMobile';

  Client client;

  PresensiClient(this.client);

  static Future<List<Presensi>> fetchAllMock(Client client) async {
    try {
      var response = await client.get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['presensi'];

      return list.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Presensi>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<dynamic> jsonArray = json.decode(response.body)['presensi'];

      List<Presensi> presensiList = [];
      jsonArray.forEach((presensiJson) {
        presensiList.add(Presensi.fromJson(presensiJson));
      });

      return presensiList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

static Future<void> update(int id, String status) async {
  try {
    var response = await put(Uri.http(url, '$endpoint/$id'), body: jsonEncode({'status': status}));
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);
  } catch (e) {
    throw Exception('Failed to update presensi: $e');
  }
}

}
