class StringContentUtil {
  factory StringContentUtil() => _instance;
  StringContentUtil.internal();
  static final StringContentUtil _instance = StringContentUtil.internal();

  static const String loginTitle = 'Login';
  static const String loginButtonTitle = 'Masuk';
  static const String emailHintText = 'user@mail.com';
  static const String emailTitleText = 'Email';
  static const String passHintText = 'xxxxxxxxxxxx';
  static const String passTitleText = 'Password';
}
