import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class GetProviderBasedProfileResponse {
  String providerId;
  String namedId;
  String displayName;
  String avatarUrl;
  String providerName;
  String emailAddress;

  GetProviderBasedProfileResponse(
      {this.providerId,
      this.namedId,
      this.providerName,
      this.avatarUrl,
      this.displayName,
      this.emailAddress});

  factory GetProviderBasedProfileResponse.fromJson(Map<String, dynamic> json) => _$GetProviderBasedProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProviderBasedProfileResponseToJson(this);
}

@JsonSerializable()
class GetUserResponse {
  String platformId;
  String providerId;
  String providerName;
  String emailAddress;
  String displayName;
  String avatarUrl;

  GetUserResponse(
      {this.emailAddress,
      this.displayName,
      this.avatarUrl,
      this.providerName,
      this.providerId,
      this.platformId});

  factory GetUserResponse.fromJson(Map<String, dynamic> json) => _$GetUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);
}
