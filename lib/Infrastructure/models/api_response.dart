import 'dart:convert';

ApiResponse<T> apiResponseFromJson<T>(String str, T Function(Map<String, dynamic>) fromJsonT) => ApiResponse<T>.fromJson(json.decode(str), fromJsonT);

String apiResponseToJson<T>(ApiResponse<T> data) => json.encode(data.toJson());

class ApiResponse<T> {
  final List<T> data;
  final String message;
  final Meta meta;

  ApiResponse({
    required this.data,
    required this.message,
    required this.meta,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) => ApiResponse(
    data: List<T>.from(json["Data"].map((x) => fromJsonT(x))),
    message: json["Message"],
    meta: Meta.fromJson(json["Meta"]),
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toString())),
    "Message": message,
    "Meta": meta.toJson(),
  };
}

class T {
  // Define los campos de DataDreamResponseDto aquí

  T();

  factory T.fromJson(Map<String, dynamic> json) {
    // Parse los datos para el objeto DataDreamResponseDto
    return T();
  }

  Map<String, dynamic> toJson() {
    return {
      // Añadir las propiedades de DataDreamResponseDto
    };
  }
}

class Meta {
  final int totalCount;
  final int pageSize;
  final int currentPage;
  final int totalPages;
  final bool hasNextPage;
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
    required this.hasNextPage,
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
    hasNextPage: json["HasNexPage"],  // Nota: tu propiedad tiene un error tipográfico ("HasNexPage" debería ser "HasNextPage")
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
    "HasNexPage": hasNextPage,  // Corrección también aquí
    "HasPreviousPage": hasPreviousPage,
    "NextPageUrl": nextPageUrl,
    "PreviousPageUrl": previousPageUrl,
    "NextPageNumber": nextPageNumber,
    "PreviousPageNumber": previousPageNumber,
  };
}