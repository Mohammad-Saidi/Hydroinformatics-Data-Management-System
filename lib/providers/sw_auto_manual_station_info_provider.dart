import 'package:flutter/material.dart';
import 'package:hydroinformatics_data_management_system/models/sw_auto_manual_station_info_model.dart';
import 'package:hydroinformatics_data_management_system/services/sw_auto_manual_station_info_service.dart';
import 'package:path/path.dart';

class SurfaceWaterAutoManualInfoProvider extends ChangeNotifier {
  SwAutoManualStationInfoModel? swAutoManualStationInfoObject;
  SwStation? swStation;

  List<SwStation> swStationList = [];
  List<String> stationNames = [];


  Future<void> surfaceWaterAutoManualInfo(context, value) async {

    swStationList.clear();
    stationNames.clear();



    final data = await SurfaceWaterAutoManualStationInfoService
        .getSurfaceWaterAutoManualStationInfoService(value);
    if (data != null) {
      swAutoManualStationInfoObject =
          SwAutoManualStationInfoModel.fromJson(data);



      swAutoManualStationInfoObject!.swStation!.forEach((element) {
        swStationList.add(element);
      });

      // swStationList.forEach((element) {
      //   stationNames.add(element.stationName!);
      // });


    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Service is not working, Check Api Please'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    }
  }



  void getStationList() {


    swStationList.forEach((element) {
      stationNames.add(element.stationName!);
    });
  }



  String? getStationCode(String stationName) {
    String? stationCode;
    for (var element in swStationList) {
      if (element.stationName == stationName) {
        stationCode = element.stationCode;
      }
    }
    return stationCode;
  }




}
