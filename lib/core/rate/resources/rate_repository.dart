import 'dart:async';
import '../../../main.dart';
import 'rate_api_provider.dart';

class RateRepository {
  final _provider = RateApiProvider();

  Future<ApiResponse<T?>>
      fetchAllData<T extends BaseModel, K extends EditBaseModel>({
    required Map<String, dynamic> params,
  }) =>
          _provider.fetchAllRates<T>(params: params);

  Future<ApiResponse<T?>>
      editProfile<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) =>
          _provider.editProfile<T, K>(
            editModel: editModel,
          );

  Future<ApiResponse<T?>>
      editObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editUserById<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      deleteObject<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.deleteUserById<T>(
            id: id,
          );
  Future<ApiResponse<T?>>
      createRate<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.createRate<T, K>(
            editModel: editModel,
            id: id,
          );
}
