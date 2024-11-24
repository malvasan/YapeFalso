// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_transfers_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transfersFilteredHash() => r'1223b4204bfe3677666296db71d933fa5299b4dc';

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

/// See also [transfersFiltered].
@ProviderFor(transfersFiltered)
const transfersFilteredProvider = TransfersFilteredFamily();

/// See also [transfersFiltered].
class TransfersFilteredFamily extends Family<AsyncValue<List<Transfer>>> {
  /// See also [transfersFiltered].
  const TransfersFilteredFamily();

  /// See also [transfersFiltered].
  TransfersFilteredProvider call({
    required DateTime date,
  }) {
    return TransfersFilteredProvider(
      date: date,
    );
  }

  @override
  TransfersFilteredProvider getProviderOverride(
    covariant TransfersFilteredProvider provider,
  ) {
    return call(
      date: provider.date,
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
  String? get name => r'transfersFilteredProvider';
}

/// See also [transfersFiltered].
class TransfersFilteredProvider
    extends AutoDisposeFutureProvider<List<Transfer>> {
  /// See also [transfersFiltered].
  TransfersFilteredProvider({
    required DateTime date,
  }) : this._internal(
          (ref) => transfersFiltered(
            ref as TransfersFilteredRef,
            date: date,
          ),
          from: transfersFilteredProvider,
          name: r'transfersFilteredProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transfersFilteredHash,
          dependencies: TransfersFilteredFamily._dependencies,
          allTransitiveDependencies:
              TransfersFilteredFamily._allTransitiveDependencies,
          date: date,
        );

  TransfersFilteredProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<Transfer>> Function(TransfersFilteredRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransfersFilteredProvider._internal(
        (ref) => create(ref as TransfersFilteredRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transfer>> createElement() {
    return _TransfersFilteredProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransfersFilteredProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransfersFilteredRef on AutoDisposeFutureProviderRef<List<Transfer>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _TransfersFilteredProviderElement
    extends AutoDisposeFutureProviderElement<List<Transfer>>
    with TransfersFilteredRef {
  _TransfersFilteredProviderElement(super.provider);

  @override
  DateTime get date => (origin as TransfersFilteredProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
