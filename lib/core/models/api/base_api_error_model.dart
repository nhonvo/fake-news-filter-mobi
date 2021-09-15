class BaseApiError implements Exception {
  String message;

  BaseApiError({
    required this.message,
  });

  factory BaseApiError.fromJson(Map<String, dynamic> json) => BaseApiError(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
