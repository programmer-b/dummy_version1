// ignore_for_file: unnecessary_new

class LoginError {
  ErrorPayload? errorPayload;

  LoginError({this.errorPayload});

  LoginError.fromJson(Map<String, dynamic> json) {
    errorPayload = json['errorPayload'] != null
        ? new ErrorPayload.fromJson(json['errorPayload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errorPayload != null) {
      data['errorPayload'] = errorPayload!.toJson();
    }
    return data;
  }
}

class ErrorPayload {
  Errors? errors;

  ErrorPayload({this.errors});

  ErrorPayload.fromJson(Map<String, dynamic> json) {
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  String? username;
  String? password;

  Errors({this.username, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}