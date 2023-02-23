class ApiConst {
  static String verse(int page) => 'https://api.quran.com/api/v4/quran/verses/uthmani?page_number=$page';
  static const domain = 'http://quran.isistant.io/api/v1';
  static const signUp = '$domain/auth/sign_up';
  static const home = '$domain/report/dashboard';
  static const hatim = '$domain/my_quranjoin_to_hatim';

  static const socketBase = 'ws://quran.isistant.io/ws';

  static String juzSocket(String hatimId) => '/topic/$hatimId/list_of_juz';

  static String userPages(String username) => '/topic/$username/user_pages';

  static String getPagesByJuz(String juzId) => '/topic/$juzId/list_of_page';

  static const setInProgress = '/app/in_progress';
  static const setBook = '/app/book';
  static const setTodo = '/app/to_do';
  static const setDone = '/app/done';

  static Map<String, String> authMap(String token) => {'Authorization': 'Bearer $token'};
}
