class ResultModel {
  final bool success;
  final String message;
  final dynamic data;

  ResultModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
