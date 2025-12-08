import '../../domain/entity/table_entity.dart';

class CreateTableRequest {
  final String name;
  final TableStatus status;

  CreateTableRequest({
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status.toJson(),
    };
  }
}