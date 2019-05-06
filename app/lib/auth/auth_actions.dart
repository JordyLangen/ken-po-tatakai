import 'package:kenpotatakai/api/api_models.dart';
import 'package:meta/meta.dart';

@immutable
class UserRegisteredAction {
  final GetUserResponse response;

  UserRegisteredAction(this.response);
}
