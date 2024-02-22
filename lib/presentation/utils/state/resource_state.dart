import 'package:movieapp/presentation/utils/errorhandling/base/error_bundle.dart';

enum Status { IDLE, LOADING, COMPLETED, ERROR }

class ResourceState {
  Status status;
  dynamic data;
  ErrorBundle? error;

  ResourceState(this.status, this.data, this.error);

  ResourceState.idle() : status = Status.IDLE;

  ResourceState.loading() : status = Status.LOADING;

  ResourceState.completed(this.data) : status = Status.COMPLETED;

  ResourceState.error(this.error) : status = Status.ERROR;
}
