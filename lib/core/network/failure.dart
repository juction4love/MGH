class Failure {
  final String message;
  final int? statusCode;

  Failure(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure([String? message]) : super(message ?? "सर्भरमा समस्या आयो। कृपया पछि प्रयास गर्नुहोस्। (Server Error)");
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("इन्टरनेट कनेक्सन छैन। कृपया अनलाइन हुनुहोस्। (No Internet Connection)");
}

class AuthFailure extends Failure {
  AuthFailure() : super("लगइन गर्न असफल भयो। विवरण जाँच गर्नुहोस्। (Authentication Failed)");
}
