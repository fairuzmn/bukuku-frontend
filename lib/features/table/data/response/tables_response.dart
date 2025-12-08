import '../../domain/entity/table_entity.dart';

class TablesResponse {
  final List<TableEntity> tables;

  const TablesResponse({required this.tables});

  factory TablesResponse.fromJson(Map<String, dynamic> json) {
    return TablesResponse(
      tables: List.from(json['tables']).map((x) => TableEntity.fromJson(x)).toList(),
    );
  }
}
