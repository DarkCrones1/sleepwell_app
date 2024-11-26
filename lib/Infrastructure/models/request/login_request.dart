
import 'dart:convert';

LoginRequestDto loginRequestDtoFromJson(String str) => LoginRequestDto.fromJson(json.decode(str));

String loginRequestDtoToJson(LoginRequestDto data) => json.encode(data.toJson());

class LoginRequestDto {
    final String userNameOrEmail;
    final String password;

    LoginRequestDto({
        required this.userNameOrEmail,
        required this.password,
    });

    factory LoginRequestDto.fromJson(Map<String, dynamic> json) => LoginRequestDto(
        userNameOrEmail: json["UserNameOrEmail"],
        password: json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "UserNameOrEmail": userNameOrEmail,
        "Password": password,
    };
}
