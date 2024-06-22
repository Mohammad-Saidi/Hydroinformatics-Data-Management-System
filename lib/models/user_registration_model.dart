/// status : "success"
/// message : [{"user_id":"202309","name":"Test User 8","email":"test8@gmail.com","mobile_no":"01700110018","user_type_name":"BWDB Official","create_datetime":"01-DEC-2023 04:00:44 PM","storage_id":null},{"user_id":"202308","name":"Test User 7","email":"test7@gmail.com","mobile_no":"01700110017","user_type_name":"Goverment","create_datetime":"01-DEC-2023 01:11:34 PM","storage_id":"2401157429"},{"user_id":"202307","name":"Test User 6","email":"test6@gmail.com","mobile_no":"01700110016","user_type_name":"Research","create_datetime":"29-NOV-2023 01:09:21 PM","storage_id":null},{"user_id":"202305","name":"Test User 4","email":"test4@gmail.com","mobile_no":"01773768014","user_type_name":"Foreign","create_datetime":"14-NOV-2023 12:29:56 PM","storage_id":"2401118806"},{"user_id":"202303","name":"Test User 2","email":"test2@gmail.com","mobile_no":"01700110012","user_type_name":"Individuals","create_datetime":"11-NOV-2023 04:00:00 PM","storage_id":null},{"user_id":"202306","name":"Test User 5","email":"test5@gmail.com","mobile_no":"01773768015","user_type_name":"Research","create_datetime":"22-SEP-1999 12:33:07 PM","storage_id":null}]

class UserRegistrationModel {
  UserRegistrationModel({
      String? status, 
      List<Message>? message,}){
    _status = status;
    _message = message;
}

  UserRegistrationModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(Message.fromJson(v));
      });
    }
  }
  String? _status;
  List<Message>? _message;
UserRegistrationModel copyWith({  String? status,
  List<Message>? message,
}) => UserRegistrationModel(  status: status ?? _status,
  message: message ?? _message,
);
  String? get status => _status;
  List<Message>? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_id : "202309"
/// name : "Test User 8"
/// email : "test8@gmail.com"
/// mobile_no : "01700110018"
/// user_type_name : "BWDB Official"
/// create_datetime : "01-DEC-2023 04:00:44 PM"
/// storage_id : null

class Message {
  Message({
      String? userId, 
      String? name, 
      String? email, 
      String? mobileNo, 
      String? userTypeName, 
      String? createDatetime, 
      dynamic storageId,}){
    _userId = userId;
    _name = name;
    _email = email;
    _mobileNo = mobileNo;
    _userTypeName = userTypeName;
    _createDatetime = createDatetime;
    _storageId = storageId;
}

  Message.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _mobileNo = json['mobile_no'];
    _userTypeName = json['user_type_name'];
    _createDatetime = json['create_datetime'];
    _storageId = json['storage_id'];
  }
  String? _userId;
  String? _name;
  String? _email;
  String? _mobileNo;
  String? _userTypeName;
  String? _createDatetime;
  dynamic _storageId;
Message copyWith({  String? userId,
  String? name,
  String? email,
  String? mobileNo,
  String? userTypeName,
  String? createDatetime,
  dynamic storageId,
}) => Message(  userId: userId ?? _userId,
  name: name ?? _name,
  email: email ?? _email,
  mobileNo: mobileNo ?? _mobileNo,
  userTypeName: userTypeName ?? _userTypeName,
  createDatetime: createDatetime ?? _createDatetime,
  storageId: storageId ?? _storageId,
);
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get mobileNo => _mobileNo;
  String? get userTypeName => _userTypeName;
  String? get createDatetime => _createDatetime;
  dynamic get storageId => _storageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['mobile_no'] = _mobileNo;
    map['user_type_name'] = _userTypeName;
    map['create_datetime'] = _createDatetime;
    map['storage_id'] = _storageId;
    return map;
  }

}