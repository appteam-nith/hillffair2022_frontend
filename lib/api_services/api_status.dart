class Success {
  late int code;
  late Object response;
  Success({required this.code, required this.response});
}

class Failure {
  late int code;
  late Object errorResponse;
  Failure({required this.code, required this.errorResponse});
}
