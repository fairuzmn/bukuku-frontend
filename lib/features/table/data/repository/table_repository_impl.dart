import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/table/data/request/create_table_request.dart';
import 'package:bukuku_frontend/features/table/data/request/update_table_request.dart';
import 'package:bukuku_frontend/features/table/data/response/tables_response.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:fpdart/fpdart.dart';

class TableRepositoryImpl implements TableRepository {
  final DioClient dioClient;

  const TableRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse<TablesResponse>>> getAllTables() async {
    try {
      final res = await dioClient.getRequest(
        Endpoints.tables,
        decoder: (json) => TablesResponse.fromJson(json),
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<dynamic>>> createTable(CreateTableRequest request) async {
    try {
      final res = await dioClient.postRequest(
        Endpoints.tables,
        body: request.toJson(),
        decoder: (json) => {},
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> updateTable(UpdateTableRequest request) async {
    try {
      final res = await dioClient.patchRequest(
        "${Endpoints.tables}/${request.id}",
        body: request.toJson(),
        decoder: (json) => null,
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> deleteTable(int id) async {
    try {
      final res = await dioClient.deleteRequest(
        "${Endpoints.tables}/$id",
        decoder: (json) => null,
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
