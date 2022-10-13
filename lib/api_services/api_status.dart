class Success {
  late int code;
  late Object response;
  Success({required this.code, required this.response});
}

class Failure {
  late int code;
  late Object errorMessage;
  Failure({required this.code, required this.errorMessage});
}
