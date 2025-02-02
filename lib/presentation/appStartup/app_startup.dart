import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapefalso/presentation/appStartup/app_startup_controller.dart';
import 'package:yapefalso/utils.dart';

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;
  @override
  ConsumerState<AppStartupWidget> createState() => _AppStartupWidgetState();
}

class _AppStartupWidgetState extends ConsumerState<AppStartupWidget> {
  @override
  Widget build(BuildContext context) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => widget.onLoaded(context),
      error: (error, stackTrace) => AppStartupErrorWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      loading: () => AppStartupLoadingWidget(),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 15,
        color: mainColorDarker,
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({super.key, required this.message, this.onRetry});
  final String message;
  final void Function()? onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          TextButton(
            onPressed: onRetry,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
