import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_model.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_view.dart';

abstract class AppPresenter<V extends AppView, M extends AppModel> {
  V? _view;

  @protected
  abstract final M model;

  @protected
  V? get view => _view;

  void bindView(V view) {
    this._view = view;
  }

  void dispose();

  MultiBlocListener buildMultiBlocListener(BuildContext context, Widget child);
}
