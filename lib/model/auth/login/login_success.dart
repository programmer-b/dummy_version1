// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class LoginSuccess {
  DataPayload? dataPayload;

  LoginSuccess({this.dataPayload});

  LoginSuccess.fromJson(Map<String, dynamic> json) {
    dataPayload = json['dataPayload'] != null
        ? new DataPayload.fromJson(json['dataPayload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataPayload != null) {
      data['dataPayload'] = this.dataPayload!.toJson();
    }
    return data;
  }
}

class DataPayload {
  Data? data;

  DataPayload({this.data});

  DataPayload.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? username;
  String? usernameAlias;
  String? token;
  String? rbac;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
      this.username,
      this.usernameAlias,
      this.token,
      this.rbac,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    usernameAlias = json['username_alias'];
    token = json['token'];
    rbac = json['rbac'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['username_alias'] = this.usernameAlias;
    data['token'] = this.token;
    data['rbac'] = this.rbac;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

