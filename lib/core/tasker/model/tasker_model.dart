import 'package:hs_user_app/core/rate/model/rate_model.dart';

import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class TaskerModel extends BaseModel {
  final String __id;
  final String _name;
  final String _email;
  final String _address;
  final String _phoneNumber;
  final String _gender;
  final int _createdTime;
  final int _updatedTime;
  final String _avatar;
  final int _numReview;
  final double _totalRating;
  final List<CommentsModel> _comments = [];

  TaskerModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _email = json['email'] ?? '',
        _address = json['address'] ?? '',
        _phoneNumber = json['phoneNumber']?.toString() ?? '',
        _gender = json['gender'] ?? '',
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0,
        _avatar = json['avatar'] ?? '',
        _numReview = json['num_review'] ?? 0,
        _totalRating = double.tryParse(json['total_rating'].toString()) ?? 0 {
    _comments.addAll(BaseModel.mapList<CommentsModel>(
      json: json,
      key: 'comments',
    ));
  }

  Map<String, dynamic> toJson() => {
        "_id": __id,
        "name": _name,
        "email": _email,
        "address": _address,
        "phoneNumber": _phoneNumber,
        "gender": _gender,
        "created_time": _createdTime,
        "updated_time": _updatedTime,
        "avatar": _avatar,
        "numReview": _numReview,
        "totalRating": _totalRating,
        "comments": _comments,
      };

  String get id => __id;
  String get name => _name;
  String get email => _email;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get gender => _gender;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  String get avatar => _avatar;
  int get numReview => _numReview;
  double get totalRating => _totalRating;
  List<CommentsModel> get comments => _comments;
}

class EditTaskerModel extends EditBaseModel {
  String id = ''; // For editing
  String name = '';
  String email = '';
  String address = '';
  String phoneNumber = '';
  String gender = '';
  String password = '';
  String avatar = '';
  int numReview = 0;
  double totalRating = 0;

  EditTaskerModel.fromModel(TaskerModel? model) {
    id = model?.id ?? '';
    name = model?.name ?? '';
    email = model?.email ?? '';
    address = model?.address ?? '';
    phoneNumber = model?.phoneNumber ?? '';
    gender = model?.gender ?? 'Male';
    avatar = model?.avatar ?? '';
    numReview = model?.numReview ?? 0;
    totalRating = model?.totalRating ?? 0;
  }
}

class ListTaskerModel extends BaseModel {
  List<TaskerModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListTaskerModel.fromJson(Map<String, dynamic> parsedJson) {
    List<TaskerModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<TaskerModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<TaskerModel> get records => _data;
  Paging get meta => _metaData;
}
