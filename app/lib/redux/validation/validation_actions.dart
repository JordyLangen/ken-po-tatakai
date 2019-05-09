import 'package:kenpotatakai/screens.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ValidationAction {
  final Screen screen;
  final dynamic propertyKey;

  ValidationAction(this.screen, this.propertyKey);
}

@immutable
class ValidateEmailAddress extends ValidationAction {
  final String emailAddress;

  ValidateEmailAddress(Screen screen, dynamic propertyKey, this.emailAddress) : super(screen, propertyKey);
}

@immutable
class EmailAddressValidationResultAction extends ValidationAction {
  final bool isValid;
  final String emailAddress;

  EmailAddressValidationResultAction(Screen screen, dynamic propertyKey, this.emailAddress, this.isValid)
      : super(screen, propertyKey);
}

@immutable
class ValidateNonEmpty extends ValidationAction {
  final String value;

  ValidateNonEmpty(Screen screen, dynamic propertyKey, this.value) : super(screen, propertyKey);
}

@immutable
class NonEmptyValidationResultAction extends ValidationAction {
  final bool isValid;
  final String value;

  NonEmptyValidationResultAction(Screen screen, dynamic propertyKey, this.value, this.isValid)
      : super(screen, propertyKey);
}
