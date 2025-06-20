import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/messaging/domain/repositories/message_repository.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_event.dart';
import 'package:gramify/features/messaging/presentation/bloc/message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;
  MessageBloc({required this.messageRepository})
    : super(MessageInitialState()) {
    //
    on<SearchUserRequested>(_onSearchUserRequested);

    //
    on<ChattingScreenRequested>(_onChattingScreenRequested);

    on<SendMessageRequested>(_onSendMessageRequested);
  }

  _onSearchUserRequested(
    SearchUserRequested event,
    Emitter<MessageState> emit,
  ) async {
    emit(MessageLoadingState());
    try {
      final res = await messageRepository.searchUsersToChat(
        searchQuery: event.inputString,
      );
      res.fold((l) => emit(SearchUserFailureState(errorMessage: l.message)), (
        r,
      ) {
        //log('in the bloc');
        emit(SearchedUserState(searchedUserList: r));
      });
    } catch (err) {
      emit(SearchUserFailureState(errorMessage: err.toString()));
    }
  }

  _onChattingScreenRequested(
    ChattingScreenRequested event,
    Emitter<MessageState> emit,
  ) async {
    try {
      emit(MessageLoadingState());
      final res = await messageRepository.setChatRoom(userId: event.userId);
      res.fold(
        (l) => emit(LoadUserChatsFailureState(errorMessage: l.message)),
        (r) => emit(LoadUserChatsState(messages: r)),
      );
    } catch (err) {
      emit(LoadUserChatsFailureState(errorMessage: err.toString()));
    }
  }

  _onSendMessageRequested(
    SendMessageRequested event,
    Emitter<MessageState> emit,
  ) async {
    try {
      final res = await messageRepository.sendMessage(
        chatID: event.chatId,
        receipintID: event.receipintId,
        message: event.message,
      );
      final res2 = await messageRepository.loadMessage(chatId: event.chatId);
      res2.fold(
        (l) => emit(LoadUserChatsFailureState(errorMessage: l.message)),
        (r) => emit(LoadUserChatsState(messages: r)),
      );
    } catch (err) {
      emit(MessageSendFailState(errorMessage: err.toString()));
    }
  }
}
