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
    data1 = json['data_1'] != null ? new Data1.fromJson(json['data_1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data1 != null) {
      data['data_1'] = this.data1!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method'] = this.method;
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}
