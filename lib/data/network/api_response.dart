class ApiResponse<T> {
  int resultCode;
  String message;
  T data;
  dynamic error;


  ApiResponse.success({
    this.resultCode,
    this.message,
    this.data,
    this.error,
  });

  ApiResponse.error(this.message);

  bool get isSuccess => this.resultCode == 1;

  @override
  String toString() {
    return "Status : \n Message : $message \n Data : $data";
  }
}
