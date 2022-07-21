import 'package:hs_user_app/core/rate/model/rate_model.dart';
import 'package:hs_user_app/core/tasker/model/tasker_model.dart';

import '../../service/model/service_model.dart';
import '/core/user/user.dart';
import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class TaskModel extends BaseModel {
  final List<OptionModel> _selectedOption = [];
  final UserModel _postedUser;
  final TaskerTaskModel _tasker;
  final ServiceModel _service;
  final FailureReasonModel _failureReason;
  final String __id;
  final AddressModel _address;
  final String _estimateTime;
  final int _startTime;
  final int _endTime;
  final int _date;
  final String _note;
  final int _status;
  final int _typeHome;
  final bool _isDeleted;
  final int _createdTime;
  final int _updatedTime;
  final int _totalPrice;
  final List<CheckListModel> _checkList = [];
  final String _addressTitle;
  final List<CommentsModel> _comments = [];

  TaskModel.fromJson(Map<String, dynamic> json)
      : _postedUser = BaseModel.map<UserModel>(
          json: json,
          key: 'posted_user',
        ),
        _tasker = BaseModel.map<TaskerTaskModel>(
          json: json,
          key: 'tasker',
        ),
        _service = BaseModel.map<ServiceModel>(
          json: json,
          key: 'service',
        ),
        _address = BaseModel.map<AddressModel>(
          json: json,
          key: 'address',
        ),
        _failureReason = BaseModel.map<FailureReasonModel>(
          json: json,
          key: 'failure_reason',
        ),
        __id = json['_id'] ?? '',
        _estimateTime = json['estimate_time'] ?? '',
        _startTime = json['start_time'] ?? 0,
        _endTime = json['end_time'] ?? 0,
        _date = json['date'] ?? 0,
        _note = json['note'] ?? '',
        _status = json['status'] ?? 0,
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
    _comments.addAll(BaseModel.mapList<CommentsModel>(
      json: json,
      key: 'comments',
    ));
    _selectedOption.addAll(BaseModel.mapList<OptionModel>(
      json: json,
      key: 'selected_option',
    ));
  }

  Map<String, dynamic> toJson() => {
        'posted_user': _postedUser.toJson(),
        'selected_option': _selectedOption,
        'tasker': _tasker.toJson(),
        'service': _service.toJson(),
        '_id': __id,
        'address': _address,
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
        'comments': _comments,
      };

  UserModel get postedUser => _postedUser;
  TaskerTaskModel get tasker => _tasker;
  ServiceModel get service => _service;
  String get id => __id;
  AddressModel get address => _address;
  String get estimateTime => _estimateTime;
  int get startTime => _startTime;
  int get endTime => _endTime;
  int get date => _date;
  String get note => _note;
  int get status => _status;
  FailureReasonModel get failureReason => _failureReason;
  int get typeHome => _typeHome;
  bool get isDeleted => _isDeleted;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  int get totalPrice => _totalPrice;
  List<CheckListModel> get checkList => _checkList;
  String get addressTitle => _addressTitle;
  List<CommentsModel> get comments => _comments;
  List<OptionModel> get selectedOption => _selectedOption;
}

class EditTaskModel extends EditBaseModel {
  ServiceModel? service = ServiceModel.fromJson({});
  List<CheckListModel> checkList = [];
  List<OptionModel> selectedOption = [];
  AddressModel? address = AddressModel.fromJson({});
  String estimateTime = '';
  int startTime = 0;
  int endTime = 0;
  int date = 0;
  String note = '';
  int status = 0;
  int typeHome = 0;
  int totalPrice = 0;
  String addressTitle = '';

  EditTaskModel.fromModel(TaskModel? model) {
    service = model?.service;
    address = model?.address;
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
    selectedOption = model?.selectedOption ?? [];
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'service': service!.toJson(),
      'address': address!.toJson(),
      'estimate_time': estimateTime,
      'start_time': startTime,
      'end_time': endTime,
      'date': date,
      'note': note,
      'status': status,
      'type_home': typeHome,
      'totalPrice': totalPrice,
      'check_list': checkList,
      'address_title': addressTitle,
      'selected_option': selectedOption,
    };
    return params;
  }

  Map<String, dynamic> toEditTaskJson() {
    Map<String, dynamic> params = {
      'service': service!.toJson(),
      'address': address!.toJson(),
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
      'selected_option': selectedOption,
    };
    return params;
  }
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

class FailureReasonModel extends BaseModel {
  final UserModel _user;
  final String _reason;
  final TaskerTaskModel _tasker;

  FailureReasonModel.fromJson(Map<String, dynamic> json)
      : _user = BaseModel.map<UserModel>(
          json: json,
          key: 'user',
        ),
        _reason = json['reason'] ?? '',
        _tasker = BaseModel.map<TaskerTaskModel>(
          json: json,
          key: 'tasker',
        );

  Map<String, dynamic> toJson() => {
        'user': _user,
        'reason': _reason,
        'tasker': _tasker,
      };

  UserModel get user => _user;
  String get reason => _reason;
  TaskerTaskModel get tasker => _tasker;
}

class LocationGpsModel extends BaseModel {
  final String _lat;
  final String _long;

  LocationGpsModel.fromJson(Map<String, dynamic> json)
      : _lat = json['lat'] ?? '',
        _long = json['long'] ?? '';

  Map<String, dynamic> toJson() => {
        'lat': _lat,
        'long': _long,
      };

  String get lat => _lat;
  String get long => _long;
}

class AddressModel extends BaseModel {
  final String _lat;
  final String _long;
  final String _name;
  final String _location;

  AddressModel.fromJson(Map<String, dynamic> json)
      : _lat = json["lat"] ?? '',
        _long = json["long"] ?? '',
        _name = json["name"] ?? '',
        _location = json["location"] ?? '';

  Map<String, dynamic> toJson() => {
        'lat': _lat,
        'long': _long,
        'name': _name,
        'location': _location,
      };

  String get lat => _lat;
  String get long => _long;
  String get name => _name;
  String get location => _location;
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

class PostedUserModel extends BaseModel {
  final String __id;
  final String _name;
  final String _email;
  final int _phoneNumber;
  final String _address;

  PostedUserModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _email = json['email'] ?? '',
        _phoneNumber = json['phone_number'] ?? 0,
        _address = json['address'] ?? '';

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'name': _name,
        'email': _email,
        'phoneNumber': _phoneNumber,
        'address': _address,
      };

  String get id => __id;
  String get name => _name;
  String get email => _email;
  int get phoneNumber => _phoneNumber;
  String get address => _address;
}

class TaskerTaskModel extends BaseModel {
  final String __id;
  final String _name;
  final String _phoneNumber;
  final String _address;
  final String _email;
  final int _receiveTime;
  final int _deleteTime;
  final bool _isDeleted;
  final String _avatar;

  TaskerTaskModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _phoneNumber = json['phoneNumber'] ?? '',
        _address = json['address'] ?? '',
        _email = json['email'] ?? '',
        _receiveTime = json['receive_time'] ?? 0,
        _deleteTime = json['delete_time'] ?? 0,
        _isDeleted = json['is_deleted'] ?? false,
        _avatar = json['avatar'] ?? '';

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'name': _name,
        'phoneNumber': _phoneNumber,
        'address': _address,
        'email': _email,
        'receive_time': _receiveTime,
        'delete_time': _deleteTime,
        'is_deleted': _isDeleted,
        'avatar': _avatar,
      };
  String get id => __id;
  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get email => _email;
  int get receiveTime => _receiveTime;
  int get deleteTime => _deleteTime;
  bool get isDeleted => _isDeleted;
  String get avatar => _avatar;
}

class OptionModel extends BaseModel {
  final String _name;
  final int _price;
  final int _quantity;
  final String _note;
  final String __id;

  OptionModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _price = json['price'] ?? 0,
        _quantity = json['quantity'] ?? 0,
        _note = json['note'] ?? '',
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'price': _price,
        'quantity': _quantity,
        'note': _note,
        '_id': __id,
      };

  String get name => _name;
  int get price => _price;
  int get quantity => _quantity;
  String get note => _note;
  String get id => __id;
}

class AddServiceModel extends BaseModel {
  final String _name;
  final int _price;
  final String __id;

  AddServiceModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _price = json['price'] ?? 0,
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'price': _price,
        '_id': __id,
      };

  String get name => _name;
  int get price => _price;
  String get id => __id;
}
