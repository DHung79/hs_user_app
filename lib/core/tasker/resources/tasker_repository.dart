import 'dart:async';
import '../../../main.dart';
import 'tasker_api_provider.dart';

class TaskerRepository {
  final _provider = TaskerApiProvider();

  Future<ApiResponse<T?>>
      fetchDataById<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.fetchUserById<T>(
            id: id,
          );
}
