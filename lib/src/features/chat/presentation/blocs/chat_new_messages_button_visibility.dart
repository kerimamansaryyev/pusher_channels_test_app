import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/di/injection_container.dart';

@injectable
final class ChatNewMessagesButtonVisibilityCubit
    extends Cubit<ChatNewMessagesButtonVisibilityState> {
  ChatNewMessagesButtonVisibilityCubit()
      : super(
          const _Invisible(),
        );

  factory ChatNewMessagesButtonVisibilityCubit.fromEnvironment() =>
      serviceLocator<ChatNewMessagesButtonVisibilityCubit>();

  void setInvisible() {
    emit(
      const _Invisible(),
    );
  }

  void setVisible() {
    emit(
      const _Visible(),
    );
  }
}

sealed class ChatNewMessagesButtonVisibilityState {}

extension ChatNewMessagesButtonVisibilityStateExtension
    on ChatNewMessagesButtonVisibilityState {
  bool get isVisible => this is _Visible;
}

final class _Visible implements ChatNewMessagesButtonVisibilityState {
  const _Visible();
}

final class _Invisible implements ChatNewMessagesButtonVisibilityState {
  const _Invisible();
}
