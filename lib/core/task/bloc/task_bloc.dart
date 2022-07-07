import 'package:hs_user_app/core/authentication/auth.dart';
import 'package:hs_user_app/core/task/model/task_model.dart';
import 'package:hs_user_app/core/task/resources/task_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../../service/model/service_model.dart';

class TaskBloc {
  final _repository = TaskRepository();
  final BehaviorSubject<ApiResponse<ListTaskModel?>> _allDataFetcher =
      BehaviorSubject<ApiResponse<ListTaskModel>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListTaskModel?>> get allData => _allDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    final SharedPreferences sharedPreferences = await prefs;
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.

      final data =
          await _repository.fetchAllData<ListTaskModel>(params: params!);
      final currentTask = Token.fromJson(params);

      sharedPreferences.setString('authtokenTask', currentTask.token);

      if (_allDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _allDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _allDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _allDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<TaskModel> fetchDataById(String id) async {
    try {
      // Await response from server.
      final data = await _repository.fetchDataById<TaskModel>(id: id);
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<TaskModel> deleteTask({String? id}) async {
    try {
      // Await response from server.

      final data = await _repository.deleteTask<TaskModel>(id: id);
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  // Future<ServiceModel> editProfile({
  //   EditServiceModel? editModel,
  // }) async {
  //   try {
  //     // Await response from server.
  //     final data = await _repository.editProfile<ServiceModel, EditServiceModel>(
  //       editModel: editModel,
  //     );
  //     if (data.error != null) {
  //       // Error exist
  //       return Future.error(data.error!);
  //     } else {
  //       // Adding response data.
  //       return Future.value(data.model);
  //     }
  //   } on AppException catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<ServiceModel> editObject({
  //   EditServiceModel? editModel,
  //   String? id,
  // }) async {
  //   try {
  //     // Await response from server.
  //     final data = await _repository.editObject<ServiceModel, EditServiceModel>(
  //       editModel: editModel,
  //       id: id,
  //     );
  //     if (data.error != null) {
  //       // Error exist
  //       return Future.error(data.error!);
  //     } else {
  //       // Adding response data.
  //       return Future.value(data.model);
  //     }
  //   } on AppException catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<ServiceModel> getProfile() async {
  //   try {
  //     // Await response from server.
  //     final data = await _repository.getProfile<ServiceModel, EditServiceModel>();
  //     if (data.error != null) {
  //       // Error exist
  //       return Future.error(data.error!);
  //     } else {
  //       // Adding response data.
  //       return Future.value(data.model);
  //     }
  //   } on AppException catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<ServiceModel> userChangePassword({Map<String, dynamic>? params}) async {
  //   try {
  //     // Await response from server.
  //     final data =
  //         await _repository.userChangePassword<ServiceModel, EditServiceModel>(
  //       params: params,
  //     );
  //     if (data.error != null) {
  //       // Error exist
  //       return Future.error(data.error!);
  //     } else {
  //       // Adding response data.
  //       return Future.value(data.model);
  //     }
  //   } on AppException catch (e) {
  //     return Future.error(e);
  //   }
  // }

  Future<TaskModel> createTask({EditTaskModel? editModel}) async {
    try {
      // Await response from server.
      final SharedPreferences sharedPreferences = await prefs;
      serviceId = sharedPreferences.getString('id') ?? '';
      editModel?.service = ServiceModel.fromJson({'_id': serviceId});
      final data = await _repository.createTask<TaskModel, EditTaskModel>(
        editModel: editModel,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<TaskModel> editTask({
    EditTaskModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.

      final data = await _repository.editTask<TaskModel, EditTaskModel>(
        editModel: editModel,
        id: idTask,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {

      return Future.error(e);
    }
  }

  dispose() {
    _allDataFetcher.close();
    _allDataState.close();
  }
}
