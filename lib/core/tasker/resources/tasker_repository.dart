import 'dart:async';
import '../../../main.dart';
import 'tasker_api_provider.dart';

class TaskerRepository {
  final _provider = TaskerApiProvider();

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) =>
      _provider.fetchAllTaskers<T>(params: params);

  Future<ApiResponse<T?>> fetchDataById<T extends BaseModel>({
    String? id,
  }) =>
      _provider.fetchTaskerById<T>(
        id: id,
      );

  Future<ApiResponse<T?>>
      ratingTasker<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    required String taskId,
  }) =>
          _provider.ratingTasker<T, K>(
            editModel: editModel,
            taskId: taskId,
          );
}
