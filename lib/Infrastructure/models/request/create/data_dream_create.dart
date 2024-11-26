
import 'dart:convert';

DataDreamCreateDto dataDreamCreateDtoFromJson(String str) => DataDreamCreateDto.fromJson(json.decode(str));

String dataDreamCreateDtoToJson(DataDreamCreateDto data) => json.encode(data.toJson());

class DataDreamCreateDto {
    final DateTime startTime;
    final DateTime endTime;
    final int sleepQualityStatus;
    final int averageHearthRate;
    final int averageOxygenLevel;
    final int deepSleepHours;
    final int interruptions;

    DataDreamCreateDto({
        required this.startTime,
        required this.endTime,
        required this.sleepQualityStatus,
        required this.averageHearthRate,
        required this.averageOxygenLevel,
        required this.deepSleepHours,
        required this.interruptions,
    });

    factory DataDreamCreateDto.fromJson(Map<String, dynamic> json) => DataDreamCreateDto(
        startTime: DateTime.parse(json["StartTime"]),
        endTime: DateTime.parse(json["EndTime"]),
        sleepQualityStatus: json["SleepQualityStatus"],
        averageHearthRate: json["AverageHearthRate"],
        averageOxygenLevel: json["AverageOxygenLevel"],
        deepSleepHours: json["DeepSleepHours"],
        interruptions: json["Interruptions"],
    );

    Map<String, dynamic> toJson() => {
        "StartTime": startTime.toIso8601String(),
        "EndTime": endTime.toIso8601String(),
        "SleepQualityStatus": sleepQualityStatus,
        "AverageHearthRate": averageHearthRate,
        "AverageOxygenLevel": averageOxygenLevel,
        "DeepSleepHours": deepSleepHours,
        "Interruptions": interruptions,
    };
}
