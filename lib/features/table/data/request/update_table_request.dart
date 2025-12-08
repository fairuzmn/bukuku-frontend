import '../../domain/entity/table_entity.dart';

class UpdateTableRequest {
  final int id;
  final String name;
  final TableStatus status;

  UpdateTableRequest({
    required this.id,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.toJson(),
    };
  }
}