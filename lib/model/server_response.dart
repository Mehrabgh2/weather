class ServerResponse {
  final int cod;
  final String message;

  ServerResponse({
    required this.cod,
    required this.message,
  });

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    final cod = json['cod'];
    final message = json['message'];
    return ServerResponse(cod: cod, message: message);
  }
}
