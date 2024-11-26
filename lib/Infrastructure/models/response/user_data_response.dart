
import 'dart:convert';

UserDataResponseDto userDataResponseDtoFromJson(String str) => UserDataResponseDto.fromJson(json.decode(str));

String userDataResponseDtoToJson(UserDataResponseDto data) => json.encode(data.toJson());

class UserDataResponseDto {
    final int id;
    final String code;
    final String firstName;
    final String middleName;
    final String lastName;
    final String cellPhone;
    final String phone;
    final int gender;
    final String genderName;
    final DateTime birthDate;
    final int age;
    final String fullName;
    final bool isDeleted;

    UserDataResponseDto({
        required this.id,
        required this.code,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.cellPhone,
        required this.phone,
        required this.gender,
        required this.genderName,
        required this.birthDate,
        required this.age,
        required this.fullName,
        required this.isDeleted,
    });

    factory UserDataResponseDto.fromJson(Map<String, dynamic> json) => UserDataResponseDto(
        id: json["Id"],
        code: json["Code"],
        firstName: json["FirstName"],
        middleName: json["MiddleName"],
        lastName: json["LastName"],
        cellPhone: json["CellPhone"],
        phone: json["Phone"],
        gender: json["Gender"],
        genderName: json["GenderName"],
        birthDate: DateTime.parse(json["BirthDate"]),
        age: json["Age"],
        fullName: json["FullName"],
        isDeleted: json["IsDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "CellPhone": cellPhone,
        "Phone": phone,
        "Gender": gender,
        "GenderName": genderName,
        "BirthDate": birthDate.toIso8601String(),
        "Age": age,
        "FullName": fullName,
        "IsDeleted": isDeleted,
    };
}
