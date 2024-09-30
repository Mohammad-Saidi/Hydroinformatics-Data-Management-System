import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers/helper_method.dart';

class DataRequestService {
  static Future<dynamic> dataRequest(num value) async {
    dynamic data;
    try {
      final url =
          'http://103.141.9.234/himsmobappapi/api/v1/data/request/list?api_key=121212&payment_method=$value';
      //const url = 'http://192.168.91.160:8082/api/v1/data/request/list?api_key=121212';
     Uri uri = Uri.parse(url);

      // final Uri uri = Uri.parse(url).replace(
      //   queryParameters: {
      //     'api_key': 121212,
      //     'payment_method': value
      //   }
      // );

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer ${HelperMethod.getAuthToken()}'},


      );

      if (response.statusCode == 200) {
        print('OK');
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        print('else');
        return data;
      }
    } catch (e) {
      print('catch');
      return data;
    }
  }
}
