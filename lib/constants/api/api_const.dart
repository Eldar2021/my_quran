class ApiConst {
  static String verse(int page) => 'https://api.quran.com/api/v4/quran/verses/uthmani?page_number=$page';
  static const domain = 'http://157.245.104.104:8080/api/v1';
  static const signUp = '$domain/auth/sign_up';
  static const home = '$domain/report/dashboard';
}
