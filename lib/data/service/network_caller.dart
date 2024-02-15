import 'dart:convert';
import 'dart:developer';
import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:http/http.dart';

class NetWorkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log('url: $url');
    Response response = await get(Uri.parse(url), headers: {
      'token': token.toString(),
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      log('statusCode: ${response.statusCode}');
      log('response: ${response.body}');
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse['data'],
          errorMessage: decodedResponse['msg'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: null,
        errorMessage: 'Unauthorized',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: null,
        errorMessage: '',
      );
    }
  }

  Future<ResponseData> postRequest(
      {required String url,
      required Map<String, dynamic>? body,
      required String token}) async {
    log('url: $url');
    log('body: $body');
    Response response = await post(Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'token': token.toString(),
          'Content-Type': 'application/json'
        });
    log('response: ${response.body}');
    log('statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      log('statusCode: ${response.statusCode}');
      log('response: ${response.body}');
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse['data'],
          errorMessage: decodedResponse['msg'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: null,
        errorMessage: 'Unauthorized',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: null,
        errorMessage: '',
      );
    }
  }
}
