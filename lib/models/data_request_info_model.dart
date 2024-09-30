/// status : "success"
/// current_page : 1
/// data : [{"rn":"1","req_mas_id":"11525","user_name":"Jubayer005","mobile_no":"01998826869","email":"jubayer20012000@gmail.com","category":"Student","request_date":"24-SEP-24","invoice_no":"2409248542"},{"rn":"2","req_mas_id":"11515","user_name":"shawana","mobile_no":"01767009921","email":"smobashsera@gmail.com","category":"Individuals","request_date":"23-SEP-24","invoice_no":"2409231888"},{"rn":"3","req_mas_id":"11523","user_name":"Monim Abdullah","mobile_no":"01602035076","email":"monim.urp22@gmail.com","category":"Student","request_date":"24-SEP-24","invoice_no":"2409244152"}]
/// first_page_url : "http://103.141.9.234/himsmobappapi/api/v1/data/request/list?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "http://103.141.9.234/himsmobappapi/api/v1/data/request/list?page=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"http://103.141.9.234/himsmobappapi/api/v1/data/request/list?page=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : "http://103.141.9.234/himsmobappapi/api/v1/data/request/list"
/// per_page : 10
/// prev_page_url : null
/// to : 3
/// total : 3

class DataRequestInfoModel {
  DataRequestInfoModel({
      String? status, 
      num? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      num? from, 
      num? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
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

  DataRequestInfoModel.fromJson(dynamic json) {
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
  dynamic _nextPageUrl;
  String? _path;
  num? _perPage;
  dynamic _prevPageUrl;
  num? _to;
  num? _total;
DataRequestInfoModel copyWith({  String? status,
  num? currentPage,
  List<Data>? data,
  String? firstPageUrl,
  num? from,
  num? lastPage,
  String? lastPageUrl,
  List<Links>? links,
  dynamic nextPageUrl,
  String? path,
  num? perPage,
  dynamic prevPageUrl,
  num? to,
  num? total,
}) => DataRequestInfoModel(  status: status ?? _status,
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
  dynamic get nextPageUrl => _nextPageUrl;
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
/// req_mas_id : "11525"
/// user_name : "Jubayer005"
/// mobile_no : "01998826869"
/// email : "jubayer20012000@gmail.com"
/// category : "Student"
/// request_date : "24-SEP-24"
/// invoice_no : "2409248542"

class Data {
  Data({
      String? rn, 
      String? reqMasId, 
      String? userName, 
      String? mobileNo, 
      String? email, 
      String? category, 
      String? requestDate, 
      String? invoiceNo,}){
    _rn = rn;
    _reqMasId = reqMasId;
    _userName = userName;
    _mobileNo = mobileNo;
    _email = email;
    _category = category;
    _requestDate = requestDate;
    _invoiceNo = invoiceNo;
}

  Data.fromJson(dynamic json) {
    _rn = json['rn'];
    _reqMasId = json['req_mas_id'];
    _userName = json['user_name'];
    _mobileNo = json['mobile_no'];
    _email = json['email'];
    _category = json['category'];
    _requestDate = json['request_date'];
    _invoiceNo = json['invoice_no'];
  }
  String? _rn;
  String? _reqMasId;
  String? _userName;
  String? _mobileNo;
  String? _email;
  String? _category;
  String? _requestDate;
  String? _invoiceNo;
Data copyWith({  String? rn,
  String? reqMasId,
  String? userName,
  String? mobileNo,
  String? email,
  String? category,
  String? requestDate,
  String? invoiceNo,
}) => Data(  rn: rn ?? _rn,
  reqMasId: reqMasId ?? _reqMasId,
  userName: userName ?? _userName,
  mobileNo: mobileNo ?? _mobileNo,
  email: email ?? _email,
  category: category ?? _category,
  requestDate: requestDate ?? _requestDate,
  invoiceNo: invoiceNo ?? _invoiceNo,
);
  String? get rn => _rn;
  String? get reqMasId => _reqMasId;
  String? get userName => _userName;
  String? get mobileNo => _mobileNo;
  String? get email => _email;
  String? get category => _category;
  String? get requestDate => _requestDate;
  String? get invoiceNo => _invoiceNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rn'] = _rn;
    map['req_mas_id'] = _reqMasId;
    map['user_name'] = _userName;
    map['mobile_no'] = _mobileNo;
    map['email'] = _email;
    map['category'] = _category;
    map['request_date'] = _requestDate;
    map['invoice_no'] = _invoiceNo;
    return map;
  }

}