import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/redux/validation/validation_actions.dart';
import 'package:redux/redux.dart';

class ValidationMiddleware extends MiddlewareClass<AppState> {
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is ValidateEmailAddress) {
      _validateEmailAddress(action, next);
    }

    if (action is ValidateNonEmpty) {
      _validateNonEmpty(action, next);
    }

    next(action);
  }

  void _validateEmailAddress(ValidateEmailAddress action, NextDispatcher next) {
    var regex = new RegExp(emailPattern);
    var isValid = action.emailAddress != null && regex.hasMatch(action.emailAddress);
    next(EmailAddressValidationResultAction(action.screen, action.propertyKey, action.emailAddress, isValid));
  }

  void _validateNonEmpty(ValidateNonEmpty action, NextDispatcher next) {
    var isValid = action.value != null && action.value != '';
    next(NonEmptyValidationResultAction(action.screen, action.propertyKey, action.value, isValid));
  }
}
