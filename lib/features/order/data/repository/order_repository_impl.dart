import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/order/data/request/create_order_request.dart';
import 'package:bukuku_frontend/features/order/data/response/orders_response.dart';
import 'package:bukuku_frontend/features/order/domain/repository/order_repository.dart';
import 'package:fpdart/fpdart.dart';

class OrderRepositoryImpl implements OrderRepository {
  final DioClient dioClient;

  const OrderRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse>> createOrder(CreateOrderRequest request) async {
    try {
      final res = await dioClient.postRequest(
        Endpoints.orders,
        body: request.toJson(),
        decoder: (json) => {},
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<OrdersResponse>>> getAllOrders() async {
    try {
      final res = await dioClient.getRequest(
        Endpoints.orders,
        decoder: (json) => OrdersResponse.fromJson(json),
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
