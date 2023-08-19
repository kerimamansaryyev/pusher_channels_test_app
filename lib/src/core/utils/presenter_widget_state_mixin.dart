import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef Presenter<T> = BlocBase<T>;

typedef PresenterStateWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T state,
);

typedef PresenterStateBuildWhenPredicate<T> = bool Function(
  T prev,
  T next,
);

mixin PresenterWidgetStateMixin<W extends StatefulWidget,
    P extends Presenter<T>, T> {
  abstract final P presenter;

  T get currentState => presenter.state;

  Widget stateObserver({
    required PresenterStateWidgetBuilder<T> builder,
    PresenterStateBuildWhenPredicate<T>? buildWhenPredicate,
  }) =>
      BlocBuilder<P, T>(
        buildWhen: buildWhenPredicate,
        bloc: presenter,
        builder: builder,
      );
}
