import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/table/data/request/create_table_request.dart';
import 'package:bukuku_frontend/features/table/data/request/update_table_request.dart';
import 'package:bukuku_frontend/features/table/data/response/tables_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class TableRepository {
  Future<Either<Failure, RestResponse<TablesResponse>>> getAllTables();

  Future<Either<Failure, RestResponse>> createTable(CreateTableRequest request);

  Future<Either<Failure, RestResponse>> updateTable(UpdateTableRequest request);

  Future<Either<Failure, RestResponse>> deleteTable(int id);
}
