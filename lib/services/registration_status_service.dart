import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers/helper_method.dart';

class RegistrationStatusService {
  static Future<dynamic> registrationStatus(
      id, status, String? rejectionReason) async {
    dynamic data;
    try {
      // Define the common request data
      Map<String, dynamic> requestData = {
        'user_id': id,
        'user_status': status,
      };

      // Add 'rejection reason' if the action is 'reject'
      if (rejectionReason != null) {
        requestData['rejection_reason'] = rejectionReason;
      }

      const url =
          'http://103.141.9.234/himsmobappapi/api/v1/user/status/update?api_key=121212';
      //const url = 'http://192.168.91.160:8082/api/v1/user/status/update?api_key=121212';
      Uri uri = Uri.parse(url);
      final response = await http.post(
        uri,
        // body: {'user_id': id, 'user_status': status},
        body: jsonEncode(requestData),
        headers: {
          'Authorization': 'Bearer ${HelperMethod.getAuthToken()}',
          'Content-Type': 'application/json',
        },
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
