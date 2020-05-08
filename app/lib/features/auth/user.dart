import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String userId;
  String providerId;
  String platformId;
  String displayName;
  String avatarUrl;
  String providerName;
  String emailAddress;

  User();

  User.create(this.userId, this.providerId, this.platformId, this.displayName, this.avatarUrl, this.providerName,
      this.emailAddress);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{userId: $userId, providerId: $providerId, platformId: $platformId, displayName: $displayName, avatarUrl: $avatarUrl, providerName: $providerName, emailAddress: $emailAddress}';
  }
}
