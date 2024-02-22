import 'dart:async';
import 'dart:io';

import 'package:movieapp/domain/models/exception/http_exception.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_action.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_error.dart';
import 'package:movieapp/presentation/utils/errorhandling/base/error_bundle.dart';

abstract class ErrorBundleBuilder {
  final Exception _exception;
  final AppAction _appAction;

  ErrorBundleBuilder.create(this._exception, this._appAction);

  ErrorBundle handle(HTTPException exception, AppAction appAction);

  ErrorBundle build() {
    AppError appError = AppError.UNKNOWN;

    switch (_exception.runtimeType) {
      case HTTPException:
        return handle((_exception as HTTPException), _appAction);
      case TimeoutException:
        appError = AppError.TIMEOUT;
        break;
      case SocketException:
        appError = AppError.NO_INTERNET;
        break;
    }

    return ErrorBundle(_exception, _appAction, appError);
  }
}
