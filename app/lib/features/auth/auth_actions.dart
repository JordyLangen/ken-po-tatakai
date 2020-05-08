import 'package:kenpotatakai/features/auth/user.dart';
import 'package:meta/meta.dart';

@immutable
class UserRegistered {
  final User user;

  UserRegistered(this.user);
}