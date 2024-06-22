// import 'package:flutter/material.dart';
// import 'package:hydroinformatics_data_management_system/models/user_registration_model.dart';
// import 'package:hydroinformatics_data_management_system/services/user_registration_service.dart';
//
// class UserRegistrationProvider extends ChangeNotifier {
//   UserRegistrationModel? userRegistrationModel;
//   List<Message> dataList = [];
//
//   Future<void> getRegistrationInfo(context) async {
//     final data = await UserRegistrationService.userRegistration();
//
//     if (data != null) {
//       userRegistrationModel = UserRegistrationModel.fromJson(data);
//       notifyListeners();
//
//     } else {
//       showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           content: const Text('Oops! Something went wrong'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   getPendingRegistrationInfo() {
//     dataList.clear();
//     userRegistrationModel!.message!.forEach((element) {
//       dataList.add(element);
//     });
//     notifyListeners();
//   }
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hydroinformatics_data_management_system/models/user_registration_model.dart';

import '../models/user_registration_documents_model.dart';
import '../services/user_registration_documents_service.dart';

class UserRegistrationDocumentsProvider extends ChangeNotifier {

  UserRegistrationDocumentsModel? userRegistrationDocumentsModel;
  Future<String?> getRegistrationDocumentsInfo(context, storageId) async {
    final data = await UserRegistrationDocumentsService.userRegistrationDocuments(storageId);
    print('userRegistrationDocumentsService: $data');

    if (data != null) {
      print('data not equal to null');
      userRegistrationDocumentsModel = UserRegistrationDocumentsModel.fromJson(data);
      notifyListeners();
      return userRegistrationDocumentsModel?.data;

    } else {
      // showDialog<String>(
      //   context: context,
      //   builder: (BuildContext context) => AlertDialog(
      //     content: const Text('User didn\'t give any image'),
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () => Navigator.pop(context, 'OK'),
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
      return null;
    }
  }



}