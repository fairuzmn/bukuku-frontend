import 'package:bukuku_frontend/features/order/domain/entity/order_entity.dart';

class KitchenResponse {
  final List<OrderEntity> tickets;

  const KitchenResponse({required this.tickets});

  factory KitchenResponse.fromJson(Map<String, dynamic> json) {
    return KitchenResponse(
      tickets: List.from(json['orders'] ?? []).map((x) => OrderEntity.fromJson(x)).toList(),
    );
  }
}
