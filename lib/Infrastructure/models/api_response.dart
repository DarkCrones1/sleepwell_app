
import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
    final List<Datum> data;
    final String message;
    final Meta meta;

    ApiResponse({
        required this.data,
        required this.message,
        required this.meta,
    });

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        message: json["Message"],
        meta: Meta.fromJson(json["Meta"]),
    );

    Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Message": message,
        "Meta": meta.toJson(),
    };
}

class Datum {
    Datum();

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    );

    Map<String, dynamic> toJson() => {
    };
}

class Meta {
    final int totalCount;
    final int pageSize;
    final int currentPage;
    final int totalPages;
    final bool hasNexPage;
    final bool hasPreviousPage;
    final String nextPageUrl;
    final String previousPageUrl;
    final int nextPageNumber;
    final int previousPageNumber;

    Meta({
        required this.totalCount,
        required this.pageSize,
        required this.currentPage,
        required this.totalPages,
        required this.hasNexPage,
        required this.hasPreviousPage,
        required this.nextPageUrl,
        required this.previousPageUrl,
        required this.nextPageNumber,
        required this.previousPageNumber,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        hasNexPage: json["HasNexPage"],
        hasPreviousPage: json["HasPreviousPage"],
        nextPageUrl: json["NextPageUrl"],
        previousPageUrl: json["PreviousPageUrl"],
        nextPageNumber: json["NextPageNumber"],
        previousPageNumber: json["PreviousPageNumber"],
    );

    Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "HasNexPage": hasNexPage,
        "HasPreviousPage": hasPreviousPage,
        "NextPageUrl": nextPageUrl,
        "PreviousPageUrl": previousPageUrl,
        "NextPageNumber": nextPageNumber,
        "PreviousPageNumber": previousPageNumber,
    };
}
