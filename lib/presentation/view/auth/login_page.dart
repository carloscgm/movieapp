import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/domain/interfaces/view_models/auth_view_model_interface.dart';
import 'package:movieapp/presentation/utils/state/resource_state.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';
import 'package:movieapp/presentation/utils/constants/app_dimens.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';
import 'package:movieapp/presentation/utils/widgets/error/error_overlay.dart';
import 'package:movieapp/presentation/utils/widgets/input/password_form_field.dart';
import 'package:movieapp/presentation/utils/widgets/loading/loading_overlay.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authViewModel = inject<AuthViewModelInterface>();

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _authViewModel.loginState.stream.listen((state) {
      switch (state.status) {
        case Status.LOADING:
          LoadingOverlay.show(context);
          break;
        case Status.COMPLETED:
          LoadingOverlay.hide();
          context.go(NavigationRoutes.movieRoute);
          break;
        case Status.ERROR:
          LoadingOverlay.hide();
          ErrorOverlay.of(context).show(state.error);
          break;
        default:
          LoadingOverlay.hide();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimens.mediumMargin,
                vertical: AppDimens.semiMediumMargin),
            elevation: AppDimens.cardBigElevation,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: AppDimens.bigMargin),
                        Text(
                            AppLocalizations.of(context)!.sign_in_welcome_title,
                            style: AppStyles.extraBigTextStyle),
                        const SizedBox(height: AppDimens.extraSmallMargin),
                        Text(
                            AppLocalizations.of(context)!
                                .sign_in_welcome_subtitle,
                            style: AppStyles.smallTextStyle),
                        const SizedBox(height: AppDimens.semiBigMargin),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.mediumMargin),
                          child: TextFormField(
                            controller: _emailFieldController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .error_empty_field;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!
                                  .sign_in_username,
                              hintText: AppLocalizations.of(context)!
                                  .sign_in_username_hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.mediumMargin),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.mediumMargin),
                          child: PasswordFormField(
                            controller: _passwordFieldController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .error_empty_field;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context)!
                                  .sign_in_password,
                              hintText: AppLocalizations.of(context)!
                                  .sign_in_password_hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.semiBigMargin),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusManager.instance.primaryFocus
                                  ?.unfocus(); // Close keyboard

                              _authViewModel.login(_emailFieldController.text,
                                  _passwordFieldController.text);
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.sign_in),
                        ),
                        const SizedBox(height: AppDimens.mediumMargin),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  const GoogleButtonSignIn(),
                  const SizedBox(height: AppDimens.mediumMargin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authViewModel.dispose(); // Avoid memory leaks
  }
}

class GoogleButtonSignIn extends StatelessWidget {
  const GoogleButtonSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        style: const ButtonStyle(
            elevation: MaterialStatePropertyAll(3),
            iconColor: MaterialStatePropertyAll(Colors.black),
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 242, 242, 242))),
        onPressed: () {},
        icon: Image.asset(
          'assets/images/icon-google.png',
          height: 30,
          width: 30,
        ),
        label: const Text(
          'Sign in with Google',
          style: TextStyle(color: Colors.black),
        ));
  }
}
