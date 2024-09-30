/// status : "success"
/// current_page : 1
/// data : [{"rn":"1","user_id":"2931","name":"MD. MOSTAFA KAMAL","email":"mostafajewelcebuet@gmail.com","mobile_no":"01835875884","user_type_name":"BWDB Personal","create_datetime":"08-SEP-2024 11:30:56 AM","storage_id":"2409088051"},{"rn":"2","user_id":"2886","name":"Md Manjur Alahi","email":"manjuralahi.bwdb@gmail.com","mobile_no":"01843525481","user_type_name":"BWDB Personal","create_datetime":"22-AUG-2024 01:13:42 PM","storage_id":"2408228453"},{"rn":"3","user_id":"2888","name":"Kaisar Uddin","email":"kaisarbwdb@gmail.com","mobile_no":"01818942824","user_type_name":"BWDB Personal","create_datetime":"22-AUG-2024 01:13:31 PM","storage_id":"2408228744"},{"rn":"4","user_id":"2865","name":"Dip Saha","email":"sahad0056@gmail.com","mobile_no":"01753210310","user_type_name":"Student","create_datetime":"22-AUG-2024 12:12:13 PM","storage_id":"2408224299"},{"rn":"5","user_id":"2861","name":"Tonmoy Paul","email":"tonmoypaul2003@gmail.com","mobile_no":"01713684225","user_type_name":"Student","create_datetime":"20-AUG-2024 02:14:13 PM","storage_id":"2408207484"},{"rn":"6","user_id":"2656","name":"Abrar Nafis Sadeque","email":"abrarnafis43@gmail.com","mobile_no":"01776293378","user_type_name":"Student","create_datetime":"07-MAR-2024 02:14:28 PM","storage_id":"2403071493"},{"rn":"7","user_id":"2454","name":"Md. Sazedur Rahman","email":"sazedurndc@gmail.com","mobile_no":"01764700211","user_type_name":"Student","create_datetime":"08-NOV-2023 01:13:27 PM","storage_id":"2311085248"},{"rn":"8","user_id":"2451","name":"Nayeem Uddin Emon","email":"naemon53@gmail.com","mobile_no":"01642726484","user_type_name":"Student","create_datetime":"08-NOV-2023 12:00:51 AM","storage_id":"2311077846"},{"rn":"9","user_id":"2449","name":"Md.Anichur rahman Subon","email":"subongsc@gmail.com","mobile_no":"01715974295","user_type_name":"Others","create_datetime":"06-NOV-2023 09:09:02 AM","storage_id":"2311065464"},{"rn":"10","user_id":"2413","name":"Md Shakil Ahamad","email":"shakil09707@gmail.com","mobile_no":"01733526641","user_type_name":"BWDB Personal","create_datetime":"12-OCT-2023 09:09:45 AM","storage_id":"2310122242"}]
/// first_page_url : "http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=1"
/// from : 1
/// last_page : 2
/// last_page_url : "http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=2"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=1","label":"1","active":true},{"url":"http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=2","label":"2","active":false},{"url":"http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=2","label":"Next &raquo;","active":false}]
/// next_page_url : "http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration?page=2"
/// path : "http://103.141.9.234/himsmobappapi/api/v1/hidm/user/registration"
/// per_page : 10
/// prev_page_url : null
/// to : 10
/// total : 19

class UserRegistrationModel {
  UserRegistrationModel({
      String? status, 
      num? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      num? from, 
      num? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      String? nextPageUrl, 
      String? path, 
      num? perPage, 
      dynamic prevPageUrl, 
      num? to, 
      num? total,}){
    _status = status;
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  UserRegistrationModel.fromJson(dynamic json) {
    _status = json['status'];
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  String? _status;
  num? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _nextPageUrl;
  String? _path;
  num? _perPage;
  dynamic _prevPageUrl;
  num? _to;
  num? _total;
UserRegistrationModel copyWith({  String? status,
  num? currentPage,
  List<Data>? data,
  String? firstPageUrl,
  num? from,
  num? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  String? nextPageUrl,
  String? path,
  num? perPage,
  dynamic prevPageUrl,
  num? to,
  num? total,
}) => UserRegistrationModel(  status: status ?? _status,
  currentPage: currentPage ?? _currentPage,
  data: data ?? _data,
  firstPageUrl: firstPageUrl ?? _firstPageUrl,
  from: from ?? _from,
  lastPage: lastPage ?? _lastPage,
  lastPageUrl: lastPageUrl ?? _lastPageUrl,
  links: links ?? _links,
  nextPageUrl: nextPageUrl ?? _nextPageUrl,
  path: path ?? _path,
  perPage: perPage ?? _perPage,
  prevPageUrl: prevPageUrl ?? _prevPageUrl,
  to: to ?? _to,
  total: total ?? _total,
);
  String? get status => _status;
  num? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  num? get from => _from;
  num? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  num? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  num? get to => _to;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

/// url : null
/// label : "&laquo; Previous"
/// active : false

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
Links copyWith({  dynamic url,
  String? label,
  bool? active,
}) => Links(  url: url ?? _url,
  label: label ?? _label,
  active: active ?? _active,
);
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

/// rn : "1"
/// user_id : "2931"
/// name : "MD. MOSTAFA KAMAL"
/// email : "mostafajewelcebuet@gmail.com"
/// mobile_no : "01835875884"
/// user_type_name : "BWDB Personal"
/// create_datetime : "08-SEP-2024 11:30:56 AM"
/// storage_id : "2409088051"

class Data {
  Data({
      String? rn, 
      String? userId, 
      String? name, 
      String? email, 
      String? mobileNo, 
      String? userTypeName, 
      String? createDatetime, 
      String? storageId,}){
    _rn = rn;
    _userId = userId;
    _name = name;
    _email = email;
    _mobileNo = mobileNo;
    _userTypeName = userTypeName;
    _createDatetime = createDatetime;
    _storageId = storageId;
}

  Data.fromJson(dynamic json) {
    _rn = json['rn'];
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _mobileNo = json['mobile_no'];
    _userTypeName = json['user_type_name'];
    _createDatetime = json['create_datetime'];
    _storageId = json['storage_id'];
  }
  String? _rn;
  String? _userId;
  String? _name;
  String? _email;
  String? _mobileNo;
  String? _userTypeName;
  String? _createDatetime;
  String? _storageId;
Data copyWith({  String? rn,
  String? userId,
  String? name,
  String? email,
  String? mobileNo,
  String? userTypeName,
  String? createDatetime,
  String? storageId,
}) => Data(  rn: rn ?? _rn,
  userId: userId ?? _userId,
  name: name ?? _name,
  email: email ?? _email,
  mobileNo: mobileNo ?? _mobileNo,
  userTypeName: userTypeName ?? _userTypeName,
  createDatetime: createDatetime ?? _createDatetime,
  storageId: storageId ?? _storageId,
);
  String? get rn => _rn;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get mobileNo => _mobileNo;
  String? get userTypeName => _userTypeName;
  String? get createDatetime => _createDatetime;
  String? get storageId => _storageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rn'] = _rn;
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