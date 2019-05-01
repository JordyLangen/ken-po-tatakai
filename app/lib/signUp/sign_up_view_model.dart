import 'package:kenpotatakai/redux/app_state.dart';
import 'package:kenpotatakai/signUp/sign_up_actions.dart';
import 'package:kenpotatakai/signUp/sign_up_provider.dart';
import 'package:redux/redux.dart';

class SignUpViewModel {

  final SignUpProvider selectedProvider;
  final String displayName;
  final bool isLoading;

  bool get didSelectProvider => selectedProvider != null && selectedProvider != SignUpProvider.NONE;

  final Function(SignUpProvider) signUpAt;
  final Function() signUpPageLoaded;

  SignUpViewModel({this.selectedProvider, this.displayName, this.isLoading, this.signUpAt, this.signUpPageLoaded});

  factory SignUpViewModel.fromStore(Store<AppState> store) {
    final signUpState = store.state.signUpState;
    return new SignUpViewModel(
      displayName: signUpState.displayName,
      selectedProvider: signUpState.provider,
      isLoading: signUpState.isLoading,
      signUpAt: (provider) {
        store.dispatch(SignUpAtProviderAction(provider));
      },
      signUpPageLoaded: () {
        store.dispatch(SignUpPageLoadedAction());
      }
    );
  }
}