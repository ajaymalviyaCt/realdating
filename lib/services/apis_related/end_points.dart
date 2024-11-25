abstract class EndPoints {
  static const String baseUrl = "http://192.168.29.76:8000/api/"; //local
  static const String login = "${baseUrl}nurse-login";
  static const String register = "${baseUrl}nurse-register";
  static const String profile = "${baseUrl}get-nurse-profile";
  static const String updateProfile = "${baseUrl}update-nurse-profile";
  static const String logout = "${baseUrl}nurse-logout";
  static const String appointments = "${baseUrl}get-all-appointments";
  static const String acceptRejectAppointment = "${baseUrl}accept-reject-appointment";
  static const String forgotPassword = "${baseUrl}forgot-password";
  static const String verifyOtp = "${baseUrl}verify-otp";
  static const String resetPassword = "${baseUrl}reset-password";
  static const String getMyScheduledAppointments = "${baseUrl}get-my-scheduled-appointments";
  static const String markAppointmentCompleted = "${baseUrl}mark-appointment-completed";
  static const String deleteAccount = "${baseUrl}delete-nurse-account";
  static const String saveLng = "${baseUrl}change-nurse-language";
}
