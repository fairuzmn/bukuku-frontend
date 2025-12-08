import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/order/data/request/create_order_request.dart';
import 'package:bukuku_frontend/features/order/data/response/orders_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class OrderRepository {
  Future<Either<Failure, RestResponse>> createOrder(CreateOrderRequest request);

  Future<Either<Failure, RestResponse<OrdersResponse>>> getAllOrders();
}
