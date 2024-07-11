class AppRegExp {
  const AppRegExp._();

  static final duration = RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$');
  static final email = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
  static final password = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
}
