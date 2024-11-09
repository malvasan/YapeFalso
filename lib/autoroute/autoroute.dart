import 'package:auto_route/auto_route.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
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
        ),
        AutoRoute(page: PhoneRegistrationRoute.page), //sign in
        AutoRoute(page: PersonalInformationRegistrationRoute.page), //sign in
        AutoRoute(page: PasswordRegistrationRoute.page), //sign in
        AutoRoute(page: RegistrationConfirmationRoute.page), //sign in
        AutoRoute(page: LoginEmailRoute.page), //log in
        AutoRoute(page: LoginPasswordRoute.page), //log in
        AutoRoute(page: PaymentsRoute.page), //payments history
        AutoRoute(page: AllPaymentHistoryRoute.page), //all payments history
        AutoRoute(
            page: LogOutRoute
                .page), //settings and log out inside payments history
        AutoRoute(page: CameraRoute.page), //Qr scanner page
        AutoRoute(page: ContactSearchRoute.page), //contact search
        AutoRoute(page: PaymentRoute.page), //payment preparation page
        AutoRoute(page: ConfirmationRoute.page),
        AutoRoute(page: AccountTypeSelectionRoute.page),
        AutoRoute(
            page: DebitCardRegistrtation
                .page), //confirmation after payment or on click in payments history
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
