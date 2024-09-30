import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/models/district_info_model.dart';
import 'package:hydroinformatics_data_management_system/services/district_info_service.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class DistrictInfoProvider extends ChangeNotifier {
  DistrictInfoModel? districtInfoModel;
  List<DistrictInfo> districtInfoList = [];
  List<String> listOfdistrictNames = [];
  dynamic selectedDistrictId;

  Future<void> getDistrict() async {
    districtInfoList.clear();
    listOfdistrictNames.clear();

    final data = await DistrictInfoService.districtInfo();

    if (data != null) {
      if (data['status'] == 'success') {
        DistrictInfoModel districtInfoModel = DistrictInfoModel.fromJson(data);

        districtInfoModel.districtInfo!.forEach((element) {
          districtInfoList.add(element);
        });

        districtInfoList.forEach((element) {
          listOfdistrictNames.add(element.districtName!);
        });
      }
    } else {
      showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Oops! Something went wrong',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      //SystemNavigator.pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  // getDistrictName() {
  //   listOfdistrictNames.clear();
  //   for (var element in districtInfoList) {
  //     listOfdistrictNames.add(element.districtName ?? '');
  //   }
  //   notifyListeners();
  // }

  // String getDistrictNumber(String selectedDistrict) {
  //   districtInfoModel!.districtInfo!.forEach((element) {
  //     if (element.districtName == selectedDistrict) {
  //       selectedDistrictId = element.districtNo;
  //     }
  //   });
  //   return selectedDistrictId;
  //   notifyListeners();
  // }

  String? getDistrictId(String districtName) {
    // subDivisionList.forEach((element) {
    //   if (element.subdivisionName == subdivision) {
    //     filteredSubdivisionCode = element.hydsubdivcode!;
    //   }
    // });
    String? districtId;

    districtInfoList.forEach((element) {

      if (element.districtName == districtName) {
        districtId = element.districtNo;
      }

    });
    return districtId;



    notifyListeners();
  }









}
