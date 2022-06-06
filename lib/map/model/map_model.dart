import '../../core/rest/models/rest_api_response.dart';

class MapModel extends BaseModel {
  final String _description;

  MapModel.fromJson(Map<String, dynamic> json)
      : _description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'description': _description,
      };

  String get description => _description;

}
