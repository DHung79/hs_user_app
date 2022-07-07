import 'dart:convert';
import 'dart:io';
import '/core/logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../authentication/auth.dart';
import '../models/rest_api_response.dart';

class ApiBaseHelper {
  Future<ApiResponse<T>> get<T extends BaseModel>({
    required String path,
    Map<String, String>? headers,
  }) async {
    ApiResponse<T> responseJson;
    try {
      final response = await http.get(Uri.parse(path), headers: headers);
      responseJson = _returnResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<ApiResponse<T>> post<T extends BaseModel>({
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    ApiResponse<T> responseJson;
    try {
      final response = await http.post(
        Uri.parse(path),
        body: body,
        headers: headers,
      );
      responseJson = _returnResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<ApiResponse<T>> put<T extends BaseModel>({
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    ApiResponse<T> responseJson;
    try {
      final response =
          await http.put(Uri.parse(path), body: body, headers: headers);
      responseJson = _returnResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<ApiResponse<List<T>>> putList<T extends BaseModel>({
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    ApiResponse<List<T>> responseJson;
    try {
      final response =
          await http.put(Uri.parse(path), body: body, headers: headers);
      responseJson = _returnListResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<ApiResponse<T>> delete<T extends BaseModel>({
    required String path,
    Map<String, String>? headers,
  }) async {
    ApiResponse<T> apiResponse;
    try {
      final response = await http.delete(Uri.parse(path), headers: headers);
      apiResponse = _returnDeleteResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return apiResponse;
  }

  Future<bool> updateFcmToken({
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(path),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        responseJson = true;
      } else {
        responseJson = false;
      }
    } on SocketException {
      return false;
    }
    return responseJson;
  }

  Future<dynamic> login({
    required String path,
    dynamic body,
    dynamic headers,
  }) async {
    dynamic token;
    try {
      final response =
          await http.post(Uri.parse(path), body: body, headers: headers);
      token = _returnLoginResponse(response);
    } on SocketException catch (ex) {
      logDebug(ex);
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return token;
  }

  Future<dynamic> signup({
    required String path,
    dynamic body,
    dynamic headers,
  }) async {
    dynamic token;
    try {
      final response =
          await http.put(Uri.parse(path), body: body, headers: headers);
      token = _returnRegisterResponse(response);
    } on SocketException catch (ex) {
      logDebug(ex);
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return token;
  }

  Future<dynamic> logout({
    required String path,
    dynamic body,
    dynamic headers,
  }) async {
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(path), body: body, headers: headers);
      responseJson = _returnLogoutResponse(response);
    } on SocketException catch (ex) {
      logDebug(ex);
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<dynamic> checkEmail({
    required String path,
    dynamic body,
    dynamic headers,
  }) async {
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(path), body: body, headers: headers);

      responseJson = _returnLogoutResponse(response);
    } on SocketException catch (ex) {
      logDebug(ex);
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<ApiResponse<List<T>>> getList<T extends BaseModel>({
    required String path,
    Map<String, String>? headers,
  }) async {
    ApiResponse<List<T>> responseJson;
    try {
      final response = await http.get(Uri.parse(path), headers: headers);
      responseJson = _returnListResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  ApiResponse<T> _returnResponse<T extends BaseModel>(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body.toString());
      if (responseJson is Map<String, dynamic>) {
        return ApiResponse(BaseModel.fromJson<T>(responseJson), null);
      }
      if (responseJson is List<dynamic>) {
        return ApiResponse(BaseModel.listDynamic<T>(responseJson), null);
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      var parsedJson = json.decode(response.body.toString());
      ApiError _error;
      if (parsedJson is String) {
        _error = ApiError.fromJson(
          {'error_code': response.statusCode, 'error_message': parsedJson},
        );
      } else if (parsedJson is Map<String, dynamic>) {
        _error = ApiError.fromJson(parsedJson);
      } else {
        _error = ApiError.fromJson(
          {
            'error_code': response.statusCode,
            'error_message': parsedJson.toString(),
          },
        );
      }
      if (_error.errorMessage == 'token expired') {
        // Unauthenticated
        AuthenticationBlocController().authenticationBloc.add(TokenExpired());
      }
      return ApiResponse(null, ApiError.fromJson(parsedJson));
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  ApiResponse<T> _returnDeleteResponse<T extends BaseModel>(
      http.Response response) {
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return ApiResponse(BaseModel.fromJson<T>(responseJson), null);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      var parsedJson = json.decode(response.body.toString());
      ApiError _error;
      if (parsedJson is String) {
        _error = ApiError.fromJson(
          {'error_code': response.statusCode, 'error_message': parsedJson},
        );
      } else if (parsedJson is Map<String, dynamic>) {
        _error = ApiError.fromJson(parsedJson);
      } else {
        _error = ApiError.fromJson(
          {
            'error_code': response.statusCode,
            'error_message': parsedJson.toString(),
          },
        );
      }
      if (_error.errorMessage == 'token expired') {
        // Unauthenticated
        AuthenticationBlocController().authenticationBloc.add(TokenExpired());
      }
      return ApiResponse(null, ApiError.fromJson(parsedJson));
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  _returnLoginResponse(http.Response response) {
    if (response.statusCode == 200) {
      var token = response.headers['x-auth-token'];
      var map = json.decode(response.body.toString());
      var id = map['user']['_id'] ?? '';
      return {'token': token, 'id': id};
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return json.decode(response.body.toString());
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  _returnRegisterResponse(http.Response response) {
    if (response.statusCode == 200) {
      var token = response.headers['x-auth-token'];
      var map = json.decode(response.body.toString());
      var id = map['_id'] ?? '';
      return {'token': token, 'id': id};
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return json.decode(response.body.toString());
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  _returnLogoutResponse(http.Response response) {
    if (response.statusCode == 200) {
      var map = json.decode(response.body.toString());
      return map;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return json.decode(response.body.toString());
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  ApiResponse<List<T>> _returnListResponse<T extends BaseModel>(
      http.Response response) {
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body.toString());
      List<T> _list = [];
      if (responseJson is List<dynamic>) {
        for (var parsedJson in responseJson) {
          if (parsedJson is Map<String, dynamic>) {
            _list.add(BaseModel.fromJson<T>(parsedJson));
          }
        }
      }
      return ApiResponse(_list, null);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      var parsedJson = json.decode(response.body.toString());
      ApiError _error;
      if (parsedJson is String) {
        _error = ApiError.fromJson(
          {'error_code': response.statusCode, 'error_message': parsedJson},
        );
      } else if (parsedJson is Map<String, dynamic>) {
        _error = ApiError.fromJson(parsedJson);
      } else {
        _error = ApiError.fromJson(
          {
            'error_code': response.statusCode,
            'error_message': parsedJson.toString(),
          },
        );
      }
      if (_error.errorMessage == 'token expired') {
        // Unauthenticated
        AuthenticationBlocController().authenticationBloc.add(TokenExpired());
      }
      return ApiResponse(null, ApiError.fromJson(parsedJson));
    }
    return ApiResponse(
      null,
      ApiError.fromJson(
        {
          'error_code': response.statusCode,
          'error_message': 'Error occured while Communication with Server'
        },
      ),
    );
  }

  Future<ApiResponse<T>> putUpload<T extends BaseModel>({
    required String path,
    Map<String, String>? headers,
    required String field,
    required String filePath,
  }) async {
    ApiResponse<T> responseJson;

    try {
      final request = http.MultipartRequest('PUT', Uri.parse(path));
      request.headers['x-auth-token'] = headers!['x-auth-token']!;
      request.files.add(await http.MultipartFile.fromPath(field, filePath));
      final response = await http.Response.fromStream(await request.send());
      responseJson = _returnResponse<T>(response);
    } on SocketException {
      return ApiResponse(
        null,
        ApiError.fromJson(
          {'error_code': -999, 'error_message': 'No Internet Connection'},
        ),
      );
    }
    return responseJson;
  }

  Future<bool> removeFcmToken({
    required String path,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(path),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        responseJson = true;
      } else {
        responseJson = false;
      }
    } on SocketException {
      return false;
    }
    return responseJson;
  }
}
