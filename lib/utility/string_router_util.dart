class StringRouterUtil {
  factory StringRouterUtil() => _instance;
  StringRouterUtil.internal();
  static final StringRouterUtil _instance = StringRouterUtil.internal();

  static const String splashScreenRoute = '/';
  static const String loginScreenRoute = '/login-route';
  static const String reloginScreenRoute = '/relogin-route';
  static const String tabScreenRoute = '/tab-route';
  static const String form1ScreenRoute = '/form-1-route';
  static const String form2ScreenRoute = '/form-2-route';
  static const String form3ScreenRoute = '/form-3-route';
  static const String formTakePicScreenRoute = '/take-pic-route';
  static const String previewImageAssetScreenRoute = '/image-asset-route';
  static const String previewImageNetworkScreenRoute = '/image-network-route';
  static const String previewPdfNetworkScreenRoute = '/pdf-network-route';
  static const String form4ScreenRoute = '/form-4-route';
  static const String form5ScreenRoute = '/form-5-route';
  static const String searchDropdownScreenRoute = '/search-dd-route';
  static const String inboxScreenRoute = '/inbox-route';
}
