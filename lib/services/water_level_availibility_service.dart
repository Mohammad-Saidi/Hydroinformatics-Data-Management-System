import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers/helper_method.dart';

class WaterLevelAvailabilityService {
  static Future<dynamic> waterLevelAvailability() async {
    dynamic data;
    try {
      const url = 'http://103.141.9.234/himsmobappapi/api/v1/swl/availability/list?api_key=121212';
      //const url = 'http://192.168.91.160:8082/api/v1/swl/availability/list?api_key=121212';
      Uri uri = Uri.parse(url);
      final response = await http.get(uri,
          headers: {'Authorization': 'Bearer ${HelperMethod.getAuthToken()}'});

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
