import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

final loadingState = StateNotifierProvider<LoadingState, bool>(
  (ref) => LoadingState(),
);

class LoadingState extends StateNotifier<bool> {
  LoadingState() : super(false);

  void startLoading() {
    state = true;
  }

  void endLoading() {
    state = false;
  }
}
