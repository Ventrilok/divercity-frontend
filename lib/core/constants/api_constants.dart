class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://localhost:3000';
  static const String apiVersion = '';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Diver endpoints
  static const String divers = '/divers';
  static String diverById(String id) => '/divers/$id';

  // Emergency contacts endpoints
  static const String emergencyContacts = '/emergency-contacts';
  static String emergencyContactById(String id) => '/emergency-contacts/$id';
  static String emergencyContactsByDiverId(String diverId) =>
      '/emergency-contacts/diver/$diverId';

  // Dive logs endpoints
  static const String diveLogs = '/dive-logs';
  static String diveLogById(String id) => '/dive-logs/$id';
  static String diveLogsByDiverId(String diverId) => '/dive-logs/diver/$diverId';

  // Media endpoints (future)
  static const String media = '/media';
  static String mediaById(String id) => '/media/$id';
}
