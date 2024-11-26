
import 'dart:convert';

UserAccountCreateDto userAccountCreateDtoFromJson(String str) => UserAccountCreateDto.fromJson(json.decode(str));

String userAccountCreateDtoToJson(UserAccountCreateDto data) => json.encode(data.toJson());

class UserAccountCreateDto {
    final String userName;
    final String password;
    final String email;

    UserAccountCreateDto({
        required this.userName,
        required this.password,
        required this.email,
    });

    factory UserAccountCreateDto.fromJson(Map<String, dynamic> json) => UserAccountCreateDto(
        userName: json["UserName"],
        password: json["Password"],
        email: json["Email"],
    );

    Map<String, dynamic> toJson() => {
        "UserName": userName,
        "Password": password,
        "Email": email,
    };
}
