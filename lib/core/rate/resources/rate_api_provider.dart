import 'dart:async';
import 'dart:convert' as convert;
import '../../../main.dart';
import '../../base/models/upload_image.dart';
import '../../constants/api_constants.dart';
import '../../helpers/api_helper.dart';
import '../../rest/rest_api_handler_data.dart';

class RateApiProvider {
  Future<ApiResponse<T?>> fetchAllRates<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) async {
    var path =
        ApiConstants.apiDomain + ApiConstants.apiVersion + ApiConstants.rates;
    if (params.isNotEmpty) {
      var queries = <String>[];
      params.forEach((key, value) => queries.add('$key=$value'));
      path += '?' + queries.join('&');
    }
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      createRate<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) async {
    final path =
        ApiConstants.apiDomain + ApiConstants.apiVersion + ApiConstants.rates;
    final body = convert.jsonEncode(EditBaseModel.toCreateRateJson(editModel!));
    logDebug('path: $path\nbody: $body');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.postData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
  
    return response;

  }



  Future<ApiResponse<T?>>
      editProfile<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.users +
        ApiConstants.me;
    final body =
        convert.jsonEncode(EditBaseModel.toEditProfileJson(editModel!));
    logDebug('path: $path\nbody: $body');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.putData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      editUserById<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.users +
        '/$id';
    final body = convert.jsonEncode(EditBaseModel.toEditJson(editModel!));
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.putData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>> deleteUserById<T extends BaseModel>({
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.users +
        '/$id';
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.deleteData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      editPassword<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.users +
        ApiConstants.me +
        '/change-password';
    final token = await ApiHelper.getUserToken();
    final body =
        convert.jsonEncode(EditBaseModel.toChangePasswordJson(editModel!));
    logDebug('path: $path\nbody: $body');
    final response = await RestApiHandlerData.putData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  uploadImage<T extends BaseModel>({
    required UploadImage image,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.users +
        ApiConstants.upload;
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.putUpload<T>(
      path: path,
      headers: ApiHelper.upload(token),
      field: 'avatar',
      filePath: image.path!,
    );
    return response;
  }
}
