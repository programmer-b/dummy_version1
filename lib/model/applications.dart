class Applications {
  Applications({
    required this.dataPayload,
  });
  late final DataPayload dataPayload;
  
  Applications.fromJson(Map<String, dynamic> json){
    dataPayload = DataPayload.fromJson(json['dataPayload']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dataPayload'] = dataPayload.toJson();
    return _data;
  }
}

class DataPayload {
  DataPayload({
    required this.data,
  });
  late final List<Data> data;
  
  DataPayload.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.icon,
    required this.name,
    required this.url,
  });
  late final String id;
  late final String icon;
  late final String name;
  late final String url;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['icon'] = icon;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}