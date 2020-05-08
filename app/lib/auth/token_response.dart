import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable(nullable: false)
class TokenResponse {
  String authenticationToken;

  TokenResponse({this.authenticationToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
