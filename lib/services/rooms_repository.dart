import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'http_exception.dart';

class RoomsRepository {
  Response response;
  Dio _dio = new Dio();


  Future<dynamic> getRoomInvite({@required int page, String query}) async {
    print('Got here');
    if (query != null && query.isNotEmpty) {
      Map<String, dynamic> queryParams = {'query': query, 'page': page};
      try {
        Response response =
            await _dio.get('http://172.20.10.2:8000/api/conversations/room/invite', queryParameters: queryParams);
        final responseBody = response.data;
        return responseBody;
      } catch (e) {
        throw ServiceException(e);
      }
    }
  }
}
