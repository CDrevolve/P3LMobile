import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3lmobile/model/tariksaldo.dart';
import 'package:p3lmobile/model/pemasukan.dart';

class LaporanPPClient {
  static final String baseUrl = '10.0.2.2:8000'; // base url untuk emulator
  static final String endpoint = 'api/laporanPPMobile/laporan'; // base endpoint
  // base endpoint

  static Future<Pemasukan> fetchAll(String token, String dates) async {
    print('ini daates ==========' + dates);
    try {
      var response = await http.post(
        Uri.http(baseUrl, endpoint),
        headers: {'Authorization': 'Bearer $token'},
        body: {'dates': dates},
      );
      if (response.statusCode != 200) throw Exception(response.body);

      print(response.body);
      final Pemasukan pemasukan =
          Pemasukan.fromJson(json.decode(response.body)['data']);
      return pemasukan;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
