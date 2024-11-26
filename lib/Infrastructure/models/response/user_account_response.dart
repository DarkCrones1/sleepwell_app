
import 'dart:convert';

UserAccountResponseDto userAccountResponseDtoFromJson(String str) => UserAccountResponseDto.fromJson(json.decode(str));

String userAccountResponseDtoToJson(UserAccountResponseDto data) => json.encode(data.toJson());

class UserAccountResponseDto {
    final int id;
    final int userDataId;
    final String userName;
    final String email;
    final String fullName;
    final String phone;
    final String cellPhone;
    final bool isDeleted;
    final DateTime createdDate;

    UserAccountResponseDto({
        required this.id,
        required this.userDataId,
        required this.userName,
        required this.email,
        required this.fullName,
        required this.phone,
        required this.cellPhone,
        required this.isDeleted,
        required this.createdDate,
    });

    factory UserAccountResponseDto.fromJson(Map<String, dynamic> json) => UserAccountResponseDto(
        id: json["Id"],
        userDataId: json["UserDataId"],
        userName: json["UserName"],
        email: json["Email"],
        fullName: json["FullName"],
        phone: json["Phone"],
        cellPhone: json["CellPhone"],
        isDeleted: json["IsDeleted"],
        createdDate: DateTime.parse(json["CreatedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserDataId": userDataId,
        "UserName": userName,
        "Email": email,
        "FullName": fullName,
        "Phone": phone,
        "CellPhone": cellPhone,
        "IsDeleted": isDeleted,
        "CreatedDate": createdDate.toIso8601String(),
    };
}
