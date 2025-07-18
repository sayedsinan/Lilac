class VerifyOtpModel {
  final String phoneNumber;
  final int otp;

  const VerifyOtpModel({
    required this.phoneNumber,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "type": "registration_otp_codes",
        "attributes": {
          "phone": "+$phoneNumber",
          "otp": otp,
        }
      }
    };
  }
}
