abstract class BaseService {
  ///API BaseUrl
  final String baseUrl = 'https://64cb8727700d50e3c7060d6b.mockapi.io/ecommerce/api';

  ///API Headers
  final headers = <String, String>{};

  Future<dynamic> getResponse(String url);
}
