import 'dart:async';
import 'package:hs_user_app/core/task/resources/task_api_provider.dart';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';

class TaskRepository {
  final _provider = TaskApiProvider();

  Future<ApiResponse<T?>> deleteObject<T extends BaseModel>({
    String? id,
  }) =>
      _provider.deleteTask<T>(
        id: id,
      );

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) =>
      _provider.fetchAllTask<T>(params: params);

  Future<ApiResponse<T?>> fetchDataById<T extends BaseModel>({
    String? id,
  }) =>
      _provider.fetchTaskById<T>(
        id: id,
      );

  Future<ApiResponse<T?>>
      editTask<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editTask<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      createTask<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) =>
          _provider.createTask<T, K>(
            editModel: editModel,
          );
}