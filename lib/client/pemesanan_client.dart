import 'dart:convert';
import 'package:http/http.dart';
import 'package:p3lmobile/model/pemesanan.dart';

class PemesananClient{
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/pesananMobile';

 Client client;

 PemesananClient(this.client);

 static Future<List<Pemesanan>> fetchAllMock(Client client) async {
  try{
    var response = await client.get(
      Uri.http(url, endpoint),
    );

    if(response.statusCode != 200) throw Exception(response.reasonPhrase);

    Iterable list = json.decode(response.body)['pemesanan'];

    return list.map((e) => Pemesanan.fromJson(e)).toList();
  } catch(e){
    return Future.error(e.toString());
  }
 }
static Future<List<Pemesanan>> fetchAll() async {
  try {
    var response = await get(Uri.http(url, endpoint));
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    List<dynamic> jsonArray = json.decode(response.body)['pemesanan']; // Mengurai respons menjadi list<dynamic>

    // Membuat objek Karyawan dari setiap elemen dalam larik JSON
    List<Pemesanan> pemesananList = [];
    jsonArray.forEach((pemesananJson) {
      pemesananList.add(Pemesanan.fromJson(pemesananJson));
    });

    return pemesananList;
  } catch (e){
    return Future.error(e.toString());
  }
}
}
