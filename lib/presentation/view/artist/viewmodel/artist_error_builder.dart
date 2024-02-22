import 'package:movieapp/domain/models/exception/http_exception.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_action.dart';
import 'package:movieapp/presentation/utils/errorhandling/app_error.dart';
import 'package:movieapp/presentation/utils/errorhandling/base/error_bundle.dart';
import 'package:movieapp/presentation/utils/errorhandling/base/error_bundle_builder.dart';

class ArtistErrorBuilder extends ErrorBundleBuilder {
  ArtistErrorBuilder.create(Exception exception, AppAction appAction)
      : super.create(exception, appAction);

  @override
  ErrorBundle handle(HTTPException exception, AppAction appAction) {
    AppError appError = AppError.UNKNOWN;

    switch (exception.statusCode) {
      case 500:
        appError = AppError.SERVER;
        break;
    }

    return ErrorBundle(exception, appAction, appError);
  }
}
