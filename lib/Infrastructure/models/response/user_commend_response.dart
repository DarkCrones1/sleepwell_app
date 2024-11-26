
import 'dart:convert';

UserCommendResponseDto userCommendResponseDtoFromJson(String str) => UserCommendResponseDto.fromJson(json.decode(str));

String userCommendResponseDtoToJson(UserCommendResponseDto data) => json.encode(data.toJson());

class UserCommendResponseDto {
    final int id;
    final String name;
    final String description;
    final String status;
    final bool isActive;
    final String code;
    final int sleepQualityStatus;
    final String sleepQualityStatusName;

    UserCommendResponseDto({
        required this.id,
        required this.name,
        required this.description,
        required this.status,
        required this.isActive,
        required this.code,
        required this.sleepQualityStatus,
        required this.sleepQualityStatusName,
    });

    factory UserCommendResponseDto.fromJson(Map<String, dynamic> json) => UserCommendResponseDto(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        status: json["Status"],
        isActive: json["IsActive"],
        code: json["Code"],
        sleepQualityStatus: json["SleepQualityStatus"],
        sleepQualityStatusName: json["SleepQualityStatusName"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Status": status,
        "IsActive": isActive,
        "Code": code,
        "SleepQualityStatus": sleepQualityStatus,
        "SleepQualityStatusName": sleepQualityStatusName,
    };
}
