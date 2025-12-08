import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/kitchen/data/response/kitchen_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class KitchenRepository {
  Future<Either<Failure, RestResponse<KitchenResponse>>> getKitchenTickets();

  Future<Either<Failure, RestResponse>> updateTicketStatus(int orderId, String status);
}
