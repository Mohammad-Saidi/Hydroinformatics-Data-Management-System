import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/models/data_request_info_model.dart';
import 'package:hydroinformatics_data_management_system/services/data_request_service.dart';

import '../main.dart';

class DataRequestProvider extends ChangeNotifier {
  DataRequestInfoModel dataRequestInfoModel = DataRequestInfoModel(data: []);
  DataRequestInfoModel searchedDataRequestInfoModel = DataRequestInfoModel(data: []);
  List<Data> dataRequestList = [];
  //String searchText = '';

  Future<void> getDataRequestInfo(context, num value) async {
    final data = await DataRequestService.dataRequest(value);
    if (data != null) {
      if (data["status"] == "success") {
        dataRequestInfoModel = DataRequestInfoModel.fromJson(data);
        updateData('Username', '');
        notifyListeners();
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
                      SystemNavigator.pop();
                    },
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  updateData(String labelText, String searchText) {
    searchedDataRequestInfoModel.data!.clear();
    //dataRequestInfoModel.dataRequestInfo!.clear();
    if (searchText.isEmpty) {
      searchedDataRequestInfoModel.data!.addAll(dataRequestInfoModel.data!);
      //dataRequestInfoModel.dataRequestInfo!.addAll(dataRequestInfoModel.dataRequestInfo!);
    } else {

      if (labelText == 'Username') {
        searchedDataRequestInfoModel.data!.addAll(
            dataRequestInfoModel.data!.where((element) => element.userName!.toLowerCase().contains(searchText)).toList()
        );
      }
      if (labelText == 'Gmail') {
        searchedDataRequestInfoModel.data!.addAll(
            dataRequestInfoModel.data!.where((element) => element.email!.toLowerCase().contains(searchText)).toList()
        );
      }
      if (labelText == 'Contact Number') {
        searchedDataRequestInfoModel.data!.addAll(
            dataRequestInfoModel.data!.where((element) => element.mobileNo!.toLowerCase().contains(searchText)).toList()
        );
      }



      // dataRequestInfoModel.dataRequestInfo!.addAll(
      //     dataRequestInfoModel.dataRequestInfo!.where((element) => element.userName!.toLowerCase().contains(searchText)).toList()
      // );


    }
    notifyListeners();
  }

  search(String labelText, String searchingText) {
    //searchText = searchingText;
    updateData(labelText, searchingText);
  }





  void getDataRequestList() {
    dataRequestList.clear();
    searchedDataRequestInfoModel.data!.forEach((element) {
      dataRequestList.add(element);
    });

    // dataRequestInfoModel.dataRequestInfo!.forEach((element) {
    //   dataRequestList.add(element);
    // });

    notifyListeners();
  }






}
