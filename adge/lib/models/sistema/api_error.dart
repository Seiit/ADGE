class ApiError {
  int? _autonumerado;
  String? _proceso;
  String? _subproceso;
  String? _parametro;
  String? _textoError;
  String? _tipoError;

  get autonumerado => this._autonumerado;

  set autonumerado(value) => this._autonumerado = value;

  get proceso => this._proceso;

  set proceso(value) => this._proceso = value;

  get subproceso => this._subproceso;

  set subproceso(value) => this._subproceso = value;

  get parametro => this._parametro;

  set parametro(value) => this._parametro = value;

  get textoError => this._textoError;

  set textoError(value) => this._textoError = value;

  get tipoError => this._tipoError;

  set tipoError(value) => this._tipoError = value;
}
