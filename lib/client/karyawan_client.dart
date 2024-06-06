import 'dart:convert';
import 'package:http/http.dart';
import 'package:p3lmobile/model/karyawan.dart';


class KaryawanClient{
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/karyawanMobile';

 Client client;

 KaryawanClient(this.client);

 static Future<List<Karyawan>> fetchAllMock(Client client) async {
  try{
    var response = await client.get(
      Uri.http(url, endpoint),
    );

    if(response.statusCode != 200) throw Exception(response.reasonPhrase);

    Iterable list = json.decode(response.body)['karyawan'];

    return list.map((e) => Karyawan.fromJson(e)).toList();
  } catch(e){
    return Future.error(e.toString());
  }
 }
static Future<List<Karyawan>> fetchAll() async {
  try {
    var response = await get(Uri.http(url, endpoint));
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    List<dynamic> jsonArray = json.decode(response.body)['karyawan']; 

    List<Karyawan> karyawanList = [];
    jsonArray.forEach((karyawanJson) {
      karyawanList.add(Karyawan.fromJson(karyawanJson));
    });

    return karyawanList;
  } catch (e){
    return Future.error(e.toString());
  }
}

}
