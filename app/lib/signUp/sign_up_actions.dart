import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:meta/meta.dart';

@immutable
class StartSignUpAction {
  final SignUpProvider provider;

  StartSignUpAction(this.provider);
}