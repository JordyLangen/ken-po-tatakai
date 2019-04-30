class KenpotatakaiApi {

  static const String ApiUrl = 'https://ken-po-tatakai.azurewebsites.net/';
  static const String AuthEndpoint = '/.auth';

  static String get authSignUpEndpoint => ApiUrl + AuthEndpoint + '/login';
}