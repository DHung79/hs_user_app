import '../../service/model/service_model.dart';
import '../../tasker/tasker.dart';
import '/core/user/user.dart';
import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class TaskModel extends BaseModel {
  final AddressModel _address;
  final UserModel _user;
  final TaskerModel _tasker;
  final ServiceModel _service;
  final String __id;
  final String _estimateTime;
  final int _startTime;
  final int _endTime;
  final int _date;
  final String _note;
  final int _status;
  final int _failureReason;
  final int _typeHome;
  final bool _isDeleted;
  final int _createdTime;
  final int _updatedTime;
  final int _totalPrice;
  final List<CheckListModel> _checkList = [];
  final String _addressTitle;
  final OptionModel _selectedOption;
  final List<String> _listPicturesBefore = [];
  final List<String> _listPicturesAfter = [];

  TaskModel.fromJson(Map<String, dynamic> json)
      : _address = BaseModel.map<AddressModel>(
          json: json,
          key: 'address',
        ),
        _user = BaseModel.map<UserModel>(
          json: json,
          key: 'posted_user',
        ),
        _tasker = BaseModel.map<TaskerModel>(
          json: json,
          key: 'tasker',
        ),
        _service = BaseModel.map<ServiceModel>(
          json: json,
          key: 'service',
        ),
        _selectedOption = BaseModel.map<OptionModel>(
          json: json,
          key: 'selected_option',
        ),
        __id = json['_id'] ?? '',
        _estimateTime = json['estimate_time'] ?? '',
        _startTime = json['start_time'] ?? 0,
        _endTime = json['end_time'] ?? 0,
        _date = json['date'] ?? 0,
        _note = json['note'] ?? '',
        _status = json['status'] ?? 0,
        _failureReason = json['failure_reason'] ?? 0,
        _typeHome = json['type_home'] ?? 0,
        _isDeleted = json['is_deleted'] ?? false,
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0,
        _totalPrice = json['total_price'] ?? 0,
        _addressTitle = json['address_title'] ?? '' {
    _checkList.addAll(BaseModel.mapList<CheckListModel>(
      json: json,
      key: 'check_list',
    ));
    if (json['list_pictures_before'] != null) {
      final jsons = json['list_pictures_before'];
      if (jsons is List<dynamic>) {
        for (var item in jsons) {
          if (item is String) {
            _listPicturesBefore.add(item);
          }
        }
      }
    }
    if (json['list_pictures_after'] != null) {
      final jsons = json['list_pictures_after'];
      if (jsons is List<dynamic>) {
        for (var item in jsons) {
          if (item is String) {
            _listPicturesAfter.add(item);
          }
        }
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'posted_user': _user.toJson(),
        'tasker': _tasker.toJson(),
        'service': _service.toJson(),
        '_id': __id,
        'estimate_time': _estimateTime,
        'start_time': _startTime,
        'end_time': _endTime,
        'date': _date,
        'note': _note,
        'status': _status,
        'failure_reason': _failureReason,
        'type_home': _typeHome,
        'is_deleted': _isDeleted,
        'created_time': _createdTime,
        'updated_time': _updatedTime,
        'total_price': _totalPrice,
        'check_list': _checkList,
        'address_title': _addressTitle,
        'selected_option': _selectedOption.toJson(),
        'list_pictures_before': _listPicturesBefore,
        'list_pictures_after': _listPicturesAfter,
      };

  AddressModel get address => _address;
  UserModel get user => _user;
  TaskerModel get tasker => _tasker;
  ServiceModel get service => _service;
  String get id => __id;
  String get estimateTime => _estimateTime;
  int get startTime => _startTime;
  int get endTime => _endTime;
  int get date => _date;
  String get note => _note;
  int get status => _status;
  int get failureReason => _failureReason;
  int get typeHome => _typeHome;
  bool get isDeleted => _isDeleted;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  int get totalPrice => _totalPrice;
  List<CheckListModel> get checkList => _checkList;
  String get addressTitle => _addressTitle;
  OptionModel get selectedOption => _selectedOption;
  List<String> get listPicturesBefore => _listPicturesBefore;
  List<String> get listPicturesAfter => _listPicturesAfter;
}

class EditTaskModel extends EditBaseModel {
  AddressModel address = AddressModel.fromJson({});
  ServiceModel? service;
  List<CheckListModel> checkList = [];
  String estimateTime = '';
  int startTime = 0;
  int endTime = 0;
  int date = 0;
  String note = '';
  int status = 0;
  int typeHome = 0;
  int totalPrice = 0;
  String addressTitle = '';
  OptionModel? selectedOption;

  EditTaskModel.fromModel(TaskModel? model) {
    address = model?.address ?? AddressModel.fromJson({});
    service = model?.service;
    estimateTime = model?.estimateTime ?? '';
    startTime = model?.startTime ?? 0;
    endTime = model?.endTime ?? 0;
    date = model?.date ?? 0;
    note = model?.note ?? '';
    status = model?.status ?? 0;
    typeHome = model?.typeHome ?? 0;
    totalPrice = model?.totalPrice ?? 0;
    checkList = model?.checkList ?? [];
    addressTitle = model?.addressTitle ?? '';
    selectedOption = model?.selectedOption;
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'address': address.toJson(),
      'service': service!.toJson(),
      'estimate_time': estimateTime,
      'start_time': startTime,
      'end_time': endTime,
      'date': date,
      'note': note,
      'status': status,
      'type_home': typeHome,
      'totalPrice': totalPrice,
      'check_list': checkList.map((e) => e.toJson()).toList(),
      'address_title': addressTitle,
      'selected_option': selectedOption?.toJson(),
    };
    return params;
  }

  Map<String, dynamic> toEditTaskJson() {
    Map<String, dynamic> params = {
      'address': address.toJson(),
      'service': service!.toJson(),
      'estimate_time': estimateTime,
      'start_time': startTime,
      'end_time': endTime,
      'date': date.toString(),
      'note': note,
      'status': status,
      'type_home': typeHome,
      'total_price': totalPrice,
      'check_list': checkList,
      'address_title': addressTitle,
      'selected_option': selectedOption!.toJson(),
    };
    return params;
  }
}

class AddressModel extends BaseModel {
  String name;
  String subName;
  String lat;
  String long;
  String location;

  AddressModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        subName = json['sub_name'] ?? '',
        lat = json['lat'] ?? '',
        long = json['long'] ?? '',
        location = json['location'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'sub_name': subName,
        'lat': lat,
        'long': long,
        'location': location,
      };
}

class ListTaskModel extends BaseModel {
  List<TaskModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListTaskModel.fromJson(Map<String, dynamic> parsedJson) {
    List<TaskModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<TaskModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<TaskModel> get records => _data;
  Paging get meta => _metaData;
}

class CheckListModel extends BaseModel {
  final String _name;
  final bool _status;
  // final String __id;

  CheckListModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _status = json['status'] ?? false;
  // __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'status': _status,
        // '_id': __id,
      };

  String get name => _name;
  bool get status => _status;
  // String get id => __id;
}
