import 'dart:async';
import 'dart:convert' as convert;
import '../../../main.dart';
import '../../constants/api_constants.dart';
import '../../helpers/api_helper.dart';
import '../../rest/rest_api_handler_data.dart';

class TaskApiProvider {
  Future<ApiResponse<T?>> fetchAllTask<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) async {
    var path =
        ApiConstants.apiDomain + ApiConstants.apiVersion + ApiConstants.tasks;
    if (params.isNotEmpty) {
      var queries = <String>[];
      params.forEach((key, value) => queries.add('$key=$value'));
      path += '?' + queries.join('&');
    }
    logDebug('path: $path');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>> fetchTaskById<T extends BaseModel>({
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.tasks +
        '/$id';
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.getData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>> deleteTask<T extends BaseModel>({
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.tasks +
        ApiConstants.user +
        '/$id';
    logDebug('path: $path');
    final token = await ApiHelper.getUserToken();
    final response = await RestApiHandlerData.deleteData<T>(
      path: path,
      headers: ApiHelper.headers(token),
    );
    return response;
  }

  Future<ApiResponse<T?>>
      createTask<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) async {
    final path =
        ApiConstants.apiDomain + ApiConstants.apiVersion + ApiConstants.tasks;
    final body = convert.jsonEncode(EditBaseModel.toCreateJson(editModel!));
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
      editTask<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) async {
    final path = ApiConstants.apiDomain +
        ApiConstants.apiVersion +
        ApiConstants.tasks +
        ApiConstants.user +
        '/$id';
    final body = convert.jsonEncode(EditBaseModel.toEditTaskJson(editModel!));
    final token = await ApiHelper.getUserToken();
    logDebug('path: $path\nbody: $body');
    final response = await RestApiHandlerData.putData<T>(
      path: path,
      body: body,
      headers: ApiHelper.headers(token),
    );
    return response;
  }
}
