import 'package:flutter/cupertino.dart';
import 'package:hydroinformatics_data_management_system/services/registration_status_service.dart';

class RegistrationStatusProvider extends ChangeNotifier {
  Future<dynamic> getRegistrationStatus(id, status, {String? rejectionReason}) async {
    final data = await RegistrationStatusService.registrationStatus(id, status, rejectionReason);

    if (data != null) {
      return data;
    } else {
      return data;
    }
  }
}
