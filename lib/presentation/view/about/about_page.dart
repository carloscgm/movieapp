import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/auth_view_model_interface.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with AutomaticKeepAliveClientMixin {
  final _authViewModel = inject<AuthViewModelInterface>();

  @override
  void initState() {
    super.initState();

    _authViewModel.signOutState.stream.listen((state) {
      switch (state) {
        case true:
          //TODO: hacer un clear del memory caché
          context.go(NavigationRoutes.initialRoute);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.about_title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.mediumMargin),
            child: Text(
                AppLocalizations.of(context)!
                    .about_description('Clean Architecture', 'Dart'),
                textAlign: TextAlign.center),
          ),
          ElevatedButton(
            onPressed: () {
              _authViewModel.signOut();
            },
            child: Text(AppLocalizations.of(context)!.sign_out),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authViewModel.dispose(); // Avoid memory leaks
  }

  @override
  bool get wantKeepAlive => true;
}
