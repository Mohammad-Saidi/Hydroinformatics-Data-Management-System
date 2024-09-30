/// status : "success"
/// sw_station : [{"station_code":"SW1","station_name":"Bagerhat","upzl_name":"Bagerhat Sadar"},{"station_code":"SW105","station_name":"Off take at Atharobanka","upzl_name":"Mollahat"},{"station_code":"SW107.2","station_name":"Rayenda","upzl_name":"Sarankhola"}]

class SwAutoManualStationInfoModel {
  SwAutoManualStationInfoModel({
      String? status, 
      List<SwStation>? swStation,}){
    _status = status;
    _swStation = swStation;
}

  SwAutoManualStationInfoModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['sw_station'] != null) {
      _swStation = [];
      json['sw_station'].forEach((v) {
        _swStation?.add(SwStation.fromJson(v));
      });
    }
  }
  String? _status;
  List<SwStation>? _swStation;
SwAutoManualStationInfoModel copyWith({  String? status,
  List<SwStation>? swStation,
}) => SwAutoManualStationInfoModel(  status: status ?? _status,
  swStation: swStation ?? _swStation,
);
  String? get status => _status;
  List<SwStation>? get swStation => _swStation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_swStation != null) {
      map['sw_station'] = _swStation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// station_code : "SW1"
/// station_name : "Bagerhat"
/// upzl_name : "Bagerhat Sadar"

class SwStation {
  SwStation({
      String? stationCode, 
      String? stationName, 
      String? upzlName,}){
    _stationCode = stationCode;
    _stationName = stationName;
    _upzlName = upzlName;
}

  SwStation.fromJson(dynamic json) {
    _stationCode = json['station_code'];
    _stationName = json['station_name'];
    _upzlName = json['upzl_name'];
  }
  String? _stationCode;
  String? _stationName;
  String? _upzlName;
SwStation copyWith({  String? stationCode,
  String? stationName,
  String? upzlName,
}) => SwStation(  stationCode: stationCode ?? _stationCode,
  stationName: stationName ?? _stationName,
  upzlName: upzlName ?? _upzlName,
);
  String? get stationCode => _stationCode;
  String? get stationName => _stationName;
  String? get upzlName => _upzlName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_code'] = _stationCode;
    map['station_name'] = _stationName;
    map['upzl_name'] = _upzlName;
    return map;
  }

}