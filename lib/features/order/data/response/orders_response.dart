import '../../domain/entity/order_entity.dart';

class OrdersResponse {
  final List<OrderEntity> orders;

  const OrdersResponse({required this.orders});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      orders: List.from(json['orders']).map((x) => OrderEntity.fromJson(x)).toList(),
    );
  }
}
