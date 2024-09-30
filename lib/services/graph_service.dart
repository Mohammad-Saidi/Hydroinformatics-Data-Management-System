import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helpers/helper_method.dart';

class GraphService {
  static Future<dynamic> hydroGraphInfo(keyword, fromDate, toDate) async {
    dynamic data;
    try {
      const url = 'http://103.141.9.234/himsmobappapi/api/v1/hydro/station/data/graph?api_key=121212';
      //const url = 'http://192.168.91.160:8082/api/v1/hydro/station/data/graph?api_key=121212';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri,
          body: {'keyword': keyword, 'from_date': fromDate, 'to_date': toDate},
          headers: {'Authorization': 'Bearer ${HelperMethod.getAuthToken()}'});

      if (response.statusCode == 200) {
        print('OK');
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        print('else');
        data = jsonDecode(response.body.toString());
        return data;
      }
    } catch (e) {
      print('catch');
      return data;
    }
  }

  static Future<dynamic> ffwcGraphInfo(keyword, fromDate, toDate, type) async {
    dynamic data;
    try {
      const url =
          'http://103.141.9.234/himsmobappapi/api/v1/ffwc/station/data/graph?api_key=121212';
      Uri uri = Uri.parse(url);
      final response = await http.post(uri, body: {
        'keyword': keyword,
        'from_date': fromDate,
        'to_date': toDate,
        'type': type
      }, headers: {
        'Authorization': 'Bearer ${HelperMethod.getAuthToken()}'
      });

      if (response.statusCode == 200) {
        print('OK');
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        print('else');
        data = jsonDecode(response.body.toString());
        return data;
      }
    } catch (e) {
      print('Sorry! catch');
      return data;
    }
  }




  static Future<dynamic> surfaceWaterDailyGraphInfo(stationNo, fromDate, toDate) async {
    dynamic data;
    try {
      const url = 'http://103.141.9.234/himsmobappapi/api/v1/surface/water/information?api_key=121212';
      //const url = 'http://192.168.91.160:8082/api/v1/hydro/station/data/graph?api_key=121212';
      Uri uri = Uri.parse(url);

      print('stationNo: $stationNo, fromDate: $fromDate, toDate: $toDate');




      final response = await http.post(uri,
          body: {'station_no': stationNo, 'from_date': fromDate, 'to_date': toDate},
          //body: {'station_no': 'SW1', 'from_date': test, 'to_date': '2024-06-27'},
          headers: {'Authorization': 'Bearer ${HelperMethod.getAuthToken()}'});


      if (response.statusCode == 200) {
        print('saidi graph ');
        print('OK');
        data = jsonDecode(response.body.toString());
        return data;
      } else {
        print('else');
        data = jsonDecode(response.body.toString());
        return data;
      }
    } catch (e) {
      print('catch');
      return data;
    }
  }


}
