import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../model/rate_model.dart';
import '../resources/rate_repository.dart';

class RateBloc {
  final _repository = RateRepository();
  final BehaviorSubject<ApiResponse<ListRateModel?>> _allDataFetcher =
      BehaviorSubject<ApiResponse<ListRateModel>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListRateModel?>> get allData => _allDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository.fetchAllData<ListRateModel, EditRateModel>(
          params: params!);
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

  Future<RateModel> createRate({EditRateModel? editModel}) async {
    try {
      // Await response from server.
      final data = await _repository.createRate<RateModel, EditRateModel>(
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

  Future<RateModel> deleteObject({String? id}) async {
    try {
      // Await response from server.
      final data =
          await _repository.deleteObject<RateModel, EditRateModel>(id: id);
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

  Future<RateModel> editObject({
    EditRateModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.editObject<RateModel, EditRateModel>(
        editModel: editModel,
        id: id,
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
