import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers/helper_method.dart';

class UserRegistrationService {
  static Future<dynamic> userRegistration() async {
    dynamic data;
    try {
      const url = 'http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?api_key=121212';
     // const url = 'http://hims.bwdb.gov.bd/himsmobappapidev/api//hidm/user/registration?api_key=121212';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
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
