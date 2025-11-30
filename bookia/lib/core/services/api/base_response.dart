class BaseResponse {
  dynamic data;
  String? message;
  List<dynamic>? error;
  int? status;

  BaseResponse({this.data, this.message, this.error, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      data: json['data'] as dynamic,
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'message': message,
    'error': error,
    'status': status,
  };
}
