import 'dart:convert';
import 'package:http/http.dart';
import 'package:p3lmobile/model/customer.dart';

class CustomerClient{
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/profileMobile';

 Client client;

 CustomerClient(this.client);

 static Future<List<Customer>> fetchAllMock(Client client) async {
  try{
    var response = await client.get(
      Uri.http(url, endpoint),
    );

    if(response.statusCode != 200) throw Exception(response.reasonPhrase);

    Iterable list = json.decode(response.body)['customer'];

    return list.map((e) => Customer.fromJson(e)).toList();
  } catch(e){
    return Future.error(e.toString());
  }
 }
static Future<List<Customer>> fetchAll() async {
  try {
    var response = await get(Uri.http(url, endpoint));
    if (response.statusCode != 200) throw Exception(response.reasonPhrase);

    List<dynamic> jsonArray = json.decode(response.body)['customer']; // Mengurai respons menjadi list<dynamic>

    List<Customer> customerList = [];
    jsonArray.forEach((customerJson) {
      customerList.add(Customer.fromJson(customerJson));
    });

    return customerList;
  } catch (e){
    return Future.error(e.toString());
  }
}

}
