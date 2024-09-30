import 'package:flutter/material.dart';
import 'package:hydroinformatics_data_management_system/models/hydro_graph_model.dart';
import 'package:hydroinformatics_data_management_system/models/rainfall_graph_model.dart';
import 'package:hydroinformatics_data_management_system/models/surface_water_graph_model.dart';

import '../models/surface_water_daily_graph_model.dart';
import '../services/graph_service.dart';

class GraphProvider extends ChangeNotifier {
  HydroGraphModel? hydroGraphModel;
  List<Data> hydroDataList = [];
  RainfallGraphModel? rainfallGraphModel;
  List<RfData> rainfallDataList = [];
  SurfaceWaterGraphModel? surfaceWaterGraphModel;
  SurfaceWaterDailyGraphModel? surfaceWaterDailyGraphModelObject;
  List<WlData> surfaceWaterDataList = [];

  List<SwStation> surfaceWaterDailyStationList = [];
  List<dynamic> surfaceWaterDailyDateTime = [];
  List<dynamic> surfaceWaterDailyDateTimeValue = [];

  List<DateTime> dateTimes = [];
  List<double> values = [];



  Future<void> showHydroGraph(keyword, fromDate, toDate, context) async {
    await GraphService.hydroGraphInfo(keyword, fromDate, toDate).then((value) {
      hydroDataList.clear();
      if (value != null) {
        if (value['status'] == 'success') {
          hydroGraphModel = HydroGraphModel.fromJson(value);
          hydroGraphModel!.data!.forEach((element) {
            hydroDataList.add(element);
          });
          notifyListeners();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(value['status']),
              content: Text(value['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Oops! Something went wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<void> showRainfallGraph(
      keyword, fromDate, toDate, type, context) async {
    await GraphService.ffwcGraphInfo(keyword, fromDate, toDate, type)
        .then((value) {
      rainfallDataList.clear();
      if (value != null) {
        if (value['status'] == 'success') {
          rainfallGraphModel = RainfallGraphModel.fromJson(value);
          rainfallGraphModel!.rFData!.forEach((element) {
            rainfallDataList.add(element);
          });
          notifyListeners();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(value['status']),
              content: Text(value['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Oops! Something went wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  Future<void> showSurfaceWaterGraph(
      keyword, fromDate, toDate, type, context) async {
    await GraphService.ffwcGraphInfo(keyword, fromDate, toDate, type)
        .then((value) {
      surfaceWaterDataList.clear();
      if (value != null) {
        if (value['status'] == 'success') {
          surfaceWaterGraphModel = SurfaceWaterGraphModel.fromJson(value);
          surfaceWaterGraphModel!.wLData!.forEach((element) {
            surfaceWaterDataList.add(element);
          });
          notifyListeners();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(value['status']),
              content: Text(value['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Oops! Something went wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }



  Future<void> showSurfaceWaterDailyGraph(
      stationNo, fromDate, toDate, context) async {
    await GraphService.surfaceWaterDailyGraphInfo(stationNo, fromDate, toDate)
        .then((value) {
      surfaceWaterDailyStationList.clear();
      surfaceWaterDailyDateTime.clear();
      surfaceWaterDailyDateTimeValue.clear();
      if (value != null) {
        if (value['status'] == 'success') {
          surfaceWaterDailyGraphModelObject = SurfaceWaterDailyGraphModel.fromJson(value);
          print('Surface Water Daily Graph Model Object: $surfaceWaterDailyGraphModelObject');
          // surfaceWaterGraphModel!.wLData!.forEach((element) {
          //   surfaceWaterDataList.add(element);
          // });
          surfaceWaterDailyGraphModelObject!.swStation!.forEach((element) {
            surfaceWaterDailyStationList.add(element);
          });


          surfaceWaterDailyStationList.forEach((element) {
            surfaceWaterDailyDateTime.add(element.datetime);
            surfaceWaterDailyDateTimeValue.add(element.value);
          });



          dateTimes = surfaceWaterDailyDateTime.map((e) => DateTime.parse(e)).toList();
          values = surfaceWaterDailyDateTimeValue.map((e) => double.parse(e)).toList();






          notifyListeners();
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(value['status']),
              content: Text(value['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: const Text('Oops! Something went wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }




}
