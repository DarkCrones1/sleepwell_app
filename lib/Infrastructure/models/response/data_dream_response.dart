import 'dart:convert';

DataDreamResponseDto dataDreamResponseDtoFromJson(String str) =>
    DataDreamResponseDto.fromJson(json.decode(str));

String dataDreamResponseDtoToJson(DataDreamResponseDto data) =>
    json.encode(data.toJson());

class DataDreamResponseDto {
  final int id;
  final String code;
  final int userDataId;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final int sleepQualityStatus;
  final String sleepQualityStatusName;
  final int averageHearthRate;
  final double averageOxygenLevel;
  final double deepSleepHours;
  final int interruptions;

  DataDreamResponseDto({
    required this.id,
    required this.code,
    required this.userDataId,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.sleepQualityStatus,
    required this.sleepQualityStatusName,
    required this.averageHearthRate,
    required this.averageOxygenLevel,
    required this.deepSleepHours,
    required this.interruptions,
  });

  factory DataDreamResponseDto.fromJson(Map<String, dynamic> json) =>
      DataDreamResponseDto(
        id: json["Id"],
        code: json["Code"],
        userDataId: json["UserDataId"],
        startTime: DateTime.parse(json["StartTime"]),
        endTime: DateTime.parse(json["EndTime"]),
        durationMinutes: json["DurationMinutes"],
        sleepQualityStatus: json["SleepQualityStatus"],
        sleepQualityStatusName: json["SleepQualityStatusName"],
        averageHearthRate: json["AverageHearthRate"],
        averageOxygenLevel:
            (json["AverageOxygenLevel"] as num).toDouble(), // Manejo seguro
        deepSleepHours:
            (json["DeepSleepHours"] as num).toDouble(), // Manejo seguro
        interruptions: json["Interruptions"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Code": code,
        "UserDataId": userDataId,
        "StartTime": startTime.toIso8601String(),
        "EndTime": endTime.toIso8601String(),
        "DurationMinutes": durationMinutes,
        "SleepQualityStatus": sleepQualityStatus,
        "SleepQualityStatusName": sleepQualityStatusName,
        "AverageHearthRate": averageHearthRate,
        "AverageOxygenLevel": averageOxygenLevel,
        "DeepSleepHours": deepSleepHours,
        "Interruptions": interruptions,
      };
}
