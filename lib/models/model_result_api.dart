class ResultModel {
  final bool success;
  final String message;
  final data;

  ResultModel({
    this.success,
    this.message,
    this.data,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      success: json['success'] as bool ?? false,
      message: json['message'] as String ?? '',
      data: json['data'],
    );
  }
}
