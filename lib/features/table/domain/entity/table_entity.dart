enum TableStatus {
  available,
  occupied,
  reserved
  ;

  String toJson() => name;

  static TableStatus fromJson(String json) {
    return TableStatus.values.firstWhere(
      (e) => e.name == json,
      orElse: () => TableStatus.available,
    );
  }
}

class TableEntity {
  final int id;
  final String name;
  final TableStatus status;

  const TableEntity({
    required this.id,
    required this.name,
    required this.status,
  });

  factory TableEntity.fromJson(Map<String, dynamic> json) {
    return TableEntity(
      id: json['id'],
      name: json['name'],
      status: TableStatus.fromJson(json['status']),
    );
  }
}
