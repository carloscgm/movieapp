import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'Flutter MVC';

  @override
  String get movie_title => 'Peliculas';

  @override
  String get artists_title => 'Artistas';

  @override
  String get about_title => 'Acerca de';

  @override
  String about_description(Object cleanArch, Object lang) {
    return 'Ejemplo de MVC con Flutter BLoC.\n\nDesarrollado en lenguaje $lang siguiendo los principios de $cleanArch por Carlos Guillén.';
  }

  @override
  String get sign_in => 'Iniciar sesión';

  @override
  String get sign_in_welcome_title => '¡Bienvenid@!';

  @override
  String get sign_in_welcome_subtitle => 'Introduce tus datos de usuario para continuar';

  @override
  String get sign_in_username => 'Usuario';

  @override
  String get sign_in_username_hint => 'Introduce tu usuario';

  @override
  String get sign_in_password => 'Contraseña';

  @override
  String get sign_in_password_hint => 'Introduce tu contraseña';

  @override
  String get sign_out => 'Cerrar sesión';

  @override
  String get error_title => 'Error';

  @override
  String get error_default => 'Ha ocurrido un error.';

  @override
  String get error_timeout => 'Estamos experimentando algunos problemas temporales. Por favor, inténtelo de nuevo en unos minutos.';

  @override
  String get error_no_internet => 'No hay conexión a Internet. Comprueba tu conexión Wi-Fi o de datos móviles, por favor.';

  @override
  String get error_server => 'Estamos experimentando algunos problemas en este momento. Por favor, vuelva de nuevo mas tarde.';

  @override
  String get error_empty_field => 'Este campo no puede estar vacío';

  @override
  String get action_ok => 'Aceptar';

  @override
  String get action_cancel => 'Cancelar';

  @override
  String get action_retry => 'Reintentar';
}
