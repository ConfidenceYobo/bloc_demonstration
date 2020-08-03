class ServiceException implements Exception {
  dynamic _exception;

  ServiceException(this._exception);

  errorMessage(){
    return _exception;
  }
}
