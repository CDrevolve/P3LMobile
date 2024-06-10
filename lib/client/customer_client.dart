import 'dart:convert';
import 'package:http/http.dart';
import 'package:p3lmobile/model/customer.dart';

class CustomerClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/profileMobile';
  static final String endpoint2 = '/api/showCustomer';

  Client client;

  CustomerClient(this.client);

  static Future<List<Customer>> fetchAllMock(Client client) async {
    try {
      var response = await client.get(
        Uri.http(url, endpoint),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['customer'];

      return list.map((e) => Customer.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Customer>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<dynamic> jsonArray = json.decode(
          response.body)['customer']; // Mengurai respons menjadi list<dynamic>

      List<Customer> customerList = [];
      jsonArray.forEach((customerJson) {
        customerList.add(Customer.fromJson(customerJson));
      });

      return customerList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Customer?> find(String token) async {
    try {
      var response = await get(Uri.http(url, endpoint2),
              headers: {'Authorization': 'Bearer $token'})
          .timeout(Duration(seconds: 5));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print(response.body);

      return Customer.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      print("Error: $e");
      throw Exception(e.toString());
    }
  }
}
