class forget_model {
  bool? success;
  String? oTP;
  String? message;

  forget_model({this.success, this.oTP, this.message});

  forget_model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    oTP = json['OTP'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['OTP'] = this.oTP;
    data['message'] = this.message;
    return data;
  }
}
