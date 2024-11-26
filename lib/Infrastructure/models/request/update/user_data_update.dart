
import 'dart:convert';

UserDataUpdateDto userDataUpdateDtoFromJson(String str) => UserDataUpdateDto.fromJson(json.decode(str));

String userDataUpdateDtoToJson(UserDataUpdateDto data) => json.encode(data.toJson());

class UserDataUpdateDto {
    final String firstName;
    final String middleName;
    final String lastName;
    final String phone;
    final String cellPhone;
    final int gender;
    final DateTime birthDate;

    UserDataUpdateDto({
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.phone,
        required this.cellPhone,
        required this.gender,
        required this.birthDate,
    });

    factory UserDataUpdateDto.fromJson(Map<String, dynamic> json) => UserDataUpdateDto(
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        phone: json["Phone"],
        cellPhone: json["CellPhone"],
        gender: json["Gender"],
        birthDate: DateTime.parse(json["BirthDate"]),
    );

    Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "Phone": phone,
        "CellPhone": cellPhone,
        "Gender": gender,
        "BirthDate": birthDate.toIso8601String(),
    };
}
