import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

import 'package:kenpotatakai/features/auth/user.dart';
import 'package:kenpotatakai/features/profile/user_statistics.dart';
import 'package:kenpotatakai/features/profile/profile_state.dart';
import 'package:kenpotatakai/redux/app_state.dart';

@immutable
class ProfileViewModel {
  User user;
  UserStatistics userStatistics;

  String get rank {
    var hasRank = userStatistics.rank != null;
    if (!hasRank) {
      return 'Unknown';
    }

    return '# ${userStatistics.rank}';
  }

  String get matchesWon => this.userStatistics.matchesWonCount.toString();
  String get matchesPlayed => this.userStatistics.matchesCount.toString();

  ProfileViewModel({@required this.user, @required this.userStatistics});

  factory ProfileViewModel.fromStore(Store<AppState> store) {
    var authState = store.state.authState;
    var profileState = store.state.profileState ?? ProfileState.initial();

    return ProfileViewModel(user: authState.user, userStatistics: profileState.userStatistics);
  }
}
