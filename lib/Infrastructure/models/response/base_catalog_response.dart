
import 'dart:convert';

BaseCatalogResponseDto baseCatalogResponseDtoFromJson(String str) => BaseCatalogResponseDto.fromJson(json.decode(str));

String baseCatalogResponseDtoToJson(BaseCatalogResponseDto data) => json.encode(data.toJson());

class BaseCatalogResponseDto {
    final int id;
    final String name;
    final String description;
    final String status;
    final bool isActive;

    BaseCatalogResponseDto({
        required this.id,
        required this.name,
        required this.description,
        required this.status,
        required this.isActive,
    });

    factory BaseCatalogResponseDto.fromJson(Map<String, dynamic> json) => BaseCatalogResponseDto(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        status: json["Status"],
        isActive: json["IsActive"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Status": status,
        "IsActive": isActive,
    };
}
