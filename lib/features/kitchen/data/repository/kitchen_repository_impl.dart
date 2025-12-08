import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/kitchen/data/response/kitchen_response.dart';
import 'package:bukuku_frontend/features/kitchen/domain/repository/kitchen_repository.dart';
import 'package:fpdart/fpdart.dart';

class KitchenRepositoryImpl implements KitchenRepository {
  final DioClient dioClient;

  const KitchenRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse<KitchenResponse>>> getKitchenTickets() async {
    try {
      final res = await dioClient.getRequest(
        Endpoints.orders,
        query: {'status': 'pending,processing'},
        decoder: (json) => KitchenResponse.fromJson(json),
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> updateTicketStatus(int orderId, String status) async {
    try {
      final res = await dioClient.patchRequest(
        "${Endpoints.orders}/$orderId/status",
        body: {'status': status},
        decoder: (json) => null,
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
