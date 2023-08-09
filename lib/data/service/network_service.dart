import 'package:http/io_client.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'app_exception.dart';
import 'base_service.dart';

class NetworkService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;

    ///Call HttpClient to set connection timeout
    final ioClient = HttpClient();
    ioClient.connectionTimeout = const Duration(seconds: 5);
    final client = http.IOClient(ioClient);

    var urlGet = Uri.parse(baseUrl + url);

    try {
      final response = await client.get(
        urlGet,
        headers: headers,
      );

      responseJson = returnResponse(response);
    } on SocketException {
      print('error');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
          'Error occured while communication with server' +
              ' with status code : ${response.statusCode}',
        );
    }
  }
}
