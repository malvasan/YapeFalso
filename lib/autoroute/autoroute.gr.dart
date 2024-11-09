// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:yapefalso/first_page.dart' as _i7;
import 'package:yapefalso/presentation/confirmation/confirmation.dart' as _i4;
import 'package:yapefalso/presentation/contact_search/contact_search_page.dart'
    as _i5;
import 'package:yapefalso/presentation/log_out/log_out_page.dart' as _i8;
import 'package:yapefalso/presentation/login/login_email_page.dart' as _i9;
import 'package:yapefalso/presentation/login/login_password_page.dart' as _i10;
import 'package:yapefalso/presentation/payment.dart/payment.dart' as _i12;
import 'package:yapefalso/presentation/payments_history/all_payment_history.dart'
    as _i2;
import 'package:yapefalso/presentation/payments_history/payments_history_page.dart'
    as _i13;
import 'package:yapefalso/presentation/qr/qr_page.dart' as _i3;
import 'package:yapefalso/presentation/registration/account_type_selection.dart'
    as _i1;
import 'package:yapefalso/presentation/registration/debit_card_registrtation.dart'
    as _i6;
import 'package:yapefalso/presentation/registration/password_registration.dart'
    as _i11;
import 'package:yapefalso/presentation/registration/personal_information_registration.dart'
    as _i14;
import 'package:yapefalso/presentation/registration/phone_registration.dart'
    as _i15;
import 'package:yapefalso/presentation/registration/registration_confirmation.dart'
    as _i16;

/// generated route for
/// [_i1.AccountTypeSelectionPage]
class AccountTypeSelectionRoute extends _i17.PageRouteInfo<void> {
  const AccountTypeSelectionRoute({List<_i17.PageRouteInfo>? children})
      : super(
          AccountTypeSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountTypeSelectionRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountTypeSelectionPage();
    },
  );
}

/// generated route for
/// [_i2.AllPaymentHistoryPage]
class AllPaymentHistoryRoute extends _i17.PageRouteInfo<void> {
  const AllPaymentHistoryRoute({List<_i17.PageRouteInfo>? children})
      : super(
          AllPaymentHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllPaymentHistoryRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllPaymentHistoryPage();
    },
  );
}

/// generated route for
/// [_i3.CameraPage]
class CameraRoute extends _i17.PageRouteInfo<void> {
  const CameraRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.CameraPage();
    },
  );
}

/// generated route for
/// [_i4.ConfirmationPage]
class ConfirmationRoute extends _i17.PageRouteInfo<ConfirmationRouteArgs> {
  ConfirmationRoute({
    required bool yapeo,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ConfirmationRoute.name,
          args: ConfirmationRouteArgs(
            yapeo: yapeo,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmationRouteArgs>();
      return _i4.ConfirmationPage(
        yapeo: args.yapeo,
        key: args.key,
      );
    },
  );
}

class ConfirmationRouteArgs {
  const ConfirmationRouteArgs({
    required this.yapeo,
    this.key,
  });

  final bool yapeo;

  final _i18.Key? key;

  @override
  String toString() {
    return 'ConfirmationRouteArgs{yapeo: $yapeo, key: $key}';
  }
}

/// generated route for
/// [_i5.ContactSearchPage]
class ContactSearchRoute extends _i17.PageRouteInfo<void> {
  const ContactSearchRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ContactSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactSearchRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.ContactSearchPage();
    },
  );
}

/// generated route for
/// [_i6.DebitCardRegistrtation]
class DebitCardRegistrtation extends _i17.PageRouteInfo<void> {
  const DebitCardRegistrtation({List<_i17.PageRouteInfo>? children})
      : super(
          DebitCardRegistrtation.name,
          initialChildren: children,
        );

  static const String name = 'DebitCardRegistrtation';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.DebitCardRegistrtation();
    },
  );
}

/// generated route for
/// [_i7.FirstPage]
class FirstRoute extends _i17.PageRouteInfo<void> {
  const FirstRoute({List<_i17.PageRouteInfo>? children})
      : super(
          FirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.FirstPage();
    },
  );
}

/// generated route for
/// [_i8.LogOutPage]
class LogOutRoute extends _i17.PageRouteInfo<void> {
  const LogOutRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LogOutRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogOutRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.LogOutPage();
    },
  );
}

/// generated route for
/// [_i9.LoginEmailPage]
class LoginEmailRoute extends _i17.PageRouteInfo<void> {
  const LoginEmailRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginEmailRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.LoginEmailPage();
    },
  );
}

/// generated route for
/// [_i10.LoginPasswordPage]
class LoginPasswordRoute extends _i17.PageRouteInfo<void> {
  const LoginPasswordRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPasswordRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.LoginPasswordPage();
    },
  );
}

/// generated route for
/// [_i11.PasswordRegistrationPage]
class PasswordRegistrationRoute extends _i17.PageRouteInfo<void> {
  const PasswordRegistrationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          PasswordRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordRegistrationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.PasswordRegistrationPage();
    },
  );
}

/// generated route for
/// [_i12.PaymentPage]
class PaymentRoute extends _i17.PageRouteInfo<void> {
  const PaymentRoute({List<_i17.PageRouteInfo>? children})
      : super(
          PaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i12.PaymentPage();
    },
  );
}

/// generated route for
/// [_i13.PaymentsPage]
class PaymentsRoute extends _i17.PageRouteInfo<void> {
  const PaymentsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          PaymentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i13.PaymentsPage();
    },
  );
}

/// generated route for
/// [_i14.PersonalInformationRegistrationPage]
class PersonalInformationRegistrationRoute extends _i17.PageRouteInfo<void> {
  const PersonalInformationRegistrationRoute(
      {List<_i17.PageRouteInfo>? children})
      : super(
          PersonalInformationRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonalInformationRegistrationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.PersonalInformationRegistrationPage();
    },
  );
}

/// generated route for
/// [_i15.PhoneRegistrationPage]
class PhoneRegistrationRoute extends _i17.PageRouteInfo<void> {
  const PhoneRegistrationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          PhoneRegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneRegistrationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.PhoneRegistrationPage();
    },
  );
}

/// generated route for
/// [_i16.RegistrationConfirmationPage]
class RegistrationConfirmationRoute extends _i17.PageRouteInfo<void> {
  const RegistrationConfirmationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegistrationConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationConfirmationRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.RegistrationConfirmationPage();
    },
  );
}
