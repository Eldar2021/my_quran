class ApiConst {
  static String verse(int page) => 'https://api.quran.com/api/v4/quran/verses/uthmani?page_number=$page';
  static const domain = 'http://192.168.1.9:8081/api/v1';
  static const signUp = '$domain/auth/sign_up';
  static const home = '$domain/report/dashboard';
  static const hatim = '$domain/hatim/join_to_hatim';

  static const socketBase = 'ws://192.168.1.9:8081/ws';

  static String juzSocket(String hatimId) => '/topic/$hatimId/list_of_juz';

  static Map<String, String> authMap(String token) => {'Authorization': 'Bearer $token'};
}
