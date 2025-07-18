
class SendOtpRequest {
  final SendOtpData data;

  SendOtpRequest({required this.data});

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class SendOtpData {
  final String type;
  final SendOtpAttributes attributes;

  SendOtpData({this.type = "registration_otp_codes", required this.attributes});

  Map<String, dynamic> toJson() => {
        'type': type,
        'attributes': attributes.toJson(),
      };
}

class SendOtpAttributes {
  final String phone;

  SendOtpAttributes({required this.phone});

  Map<String, dynamic> toJson() => {
        'phone': phone,
      };
}
