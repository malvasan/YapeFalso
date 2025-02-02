import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:yapefalso/autoroute/autoroute_provider.dart';
import 'package:yapefalso/presentation/appStartup/app_startup_controller.dart';

import 'package:yapefalso/presentation/first_page/session_controller.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AutorouteRef ref;

  AppRouter(this.ref) : super();

  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(
            page: FirstRoute.page,
            initial: true,
            guards: [SavedDataGuard(ref)]),
        AutoRoute(page: PhoneRegistrationRoute.page), //sign in
        AutoRoute(page: PersonalInformationRegistrationRoute.page), //sign in
        AutoRoute(page: PasswordRegistrationRoute.page), //sign in
        AutoRoute(page: RegistrationConfirmationRoute.page), //sign in
        AutoRoute(page: LoginEmailRoute.page), //log in
        AutoRoute(
          page: LoginPasswordRoute.page,
        ), //log in
        AutoRoute(
          page: PaymentsRoute.page,
          guards: [AuthGuard(ref)],
        ), //payments history
        AutoRoute(page: AllPaymentHistoryRoute.page), //all payments history
        AutoRoute(
            page: LogOutRoute
                .page), //settings and log out inside payments history
        AutoRoute(page: CameraRoute.page), //Qr scanner page
        AutoRoute(page: ContactSearchRoute.page), //contact search
        AutoRoute(page: PaymentRoute.page), //payment preparation page
        AutoRoute(page: ConfirmationRoute.page),
        AutoRoute(page: AccountTypeSelectionRoute.page),
        AutoRoute(page: DebitCardRegistrtation.page),
        //confirmation after payment or on click in payments history
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}

class AuthGuard extends AutoRouteGuard {
  final AutorouteRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final data = ref.watch(authenticationStateProvider);

    if (data) {
      resolver.next();
    } else {
      resolver.redirect(FirstRoute());
    }
  }
}

class SavedDataGuard extends AutoRouteGuard {
  final AutorouteRef ref;

  SavedDataGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;
    final email = prefs.getString('email');
    if (email == null) {
      resolver.next();
    } else {
      var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      numbers.shuffle();
      resolver.redirect(
        LoginPasswordRoute(
          email: email,
          numbers: numbers,
        ),
      );
    }
  }
}
