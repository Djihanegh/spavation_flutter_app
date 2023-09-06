

import 'package:dartz/dartz.dart';
import 'package:spavation/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;