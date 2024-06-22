/// status : "success"
/// type : "image/png"
/// data : "iVBORw0KGgoAAAANSUhEUgAAA8AAAADICAY

class UserRegistrationDocumentsModel {
  UserRegistrationDocumentsModel({
      String? status, 
      String? type, 
      String? data,}){
    _status = status;
    _type = type;
    _data = data;
}

  UserRegistrationDocumentsModel.fromJson(dynamic json) {
    _status = json['status'];
    _type = json['type'];
    _data = json['data'];
  }
  String? _status;
  String? _type;
  String? _data;
UserRegistrationDocumentsModel copyWith({  String? status,
  String? type,
  String? data,
}) => UserRegistrationDocumentsModel(  status: status ?? _status,
  type: type ?? _type,
  data: data ?? _data,
);
  String? get status => _status;
  String? get type => _type;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['type'] = _type;
    map['data'] = _data;
    return map;
  }

}