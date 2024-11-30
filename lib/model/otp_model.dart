class otp_verify {
  bool? success;
  String? message;
  int? status;
  Data1? data1;

  otp_verify({this.success, this.message, this.status, this.data1});

  otp_verify.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    data1 = json['data_1'] != null ? Data1.fromJson(json['data_1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['status'] = status;
    if (data1 != null) {
      data['data_1'] = data1!.toJson();
    }
    return data;
  }
}

class Data1 {
  String? id;
  String? method;
  String? status;
  String? reason;

  Data1({this.id, this.method, this.status, this.reason});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    method = json['method'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method'] = method;
    data['status'] = status;
    data['reason'] = reason;
    return data;
  }
}
