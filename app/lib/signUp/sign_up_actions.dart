import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:meta/meta.dart';

@immutable
class SignUpAtProviderAction {
  final SignUpProvider provider;

  SignUpAtProviderAction(this.provider);
}

@immutable
class SignUpPageLoadedAction {

}