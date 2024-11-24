// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transfer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userTransferHash() => r'd1d620c31436665c0ef777ccc1f8079565e4719d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userTransfer].
@ProviderFor(userTransfer)
const userTransferProvider = UserTransferFamily();

/// See also [userTransfer].
class UserTransferFamily extends Family<AsyncValue<UserMetadata>> {
  /// See also [userTransfer].
  const UserTransferFamily();

  /// See also [userTransfer].
  UserTransferProvider call({
    required int phone,
  }) {
    return UserTransferProvider(
      phone: phone,
    );
  }

  @override
  UserTransferProvider getProviderOverride(
    covariant UserTransferProvider provider,
  ) {
    return call(
      phone: provider.phone,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userTransferProvider';
}

/// See also [userTransfer].
class UserTransferProvider extends AutoDisposeFutureProvider<UserMetadata> {
  /// See also [userTransfer].
  UserTransferProvider({
    required int phone,
  }) : this._internal(
          (ref) => userTransfer(
            ref as UserTransferRef,
            phone: phone,
          ),
          from: userTransferProvider,
          name: r'userTransferProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userTransferHash,
          dependencies: UserTransferFamily._dependencies,
          allTransitiveDependencies:
              UserTransferFamily._allTransitiveDependencies,
          phone: phone,
        );

  UserTransferProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.phone,
  }) : super.internal();

  final int phone;

  @override
  Override overrideWith(
    FutureOr<UserMetadata> Function(UserTransferRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserTransferProvider._internal(
        (ref) => create(ref as UserTransferRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        phone: phone,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserMetadata> createElement() {
    return _UserTransferProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTransferProvider && other.phone == phone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserTransferRef on AutoDisposeFutureProviderRef<UserMetadata> {
  /// The parameter `phone` of this provider.
  int get phone;
}

class _UserTransferProviderElement
    extends AutoDisposeFutureProviderElement<UserMetadata>
    with UserTransferRef {
  _UserTransferProviderElement(super.provider);

  @override
  int get phone => (origin as UserTransferProvider).phone;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
