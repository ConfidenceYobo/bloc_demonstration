import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/services/rooms_repository.dart';
import 'bloc.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  final RoomsRepository roomsRepository;

  InviteBloc({@required this.roomsRepository}) : super(InviteInitial());

  @override
  Stream<Transition<InviteEvent, InviteState>> transformEvents(
    Stream<InviteEvent> events,
    TransitionFunction<InviteEvent, InviteState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<InviteState> mapEventToState(InviteEvent event) async* {
    final currentState = state;

    if (event is InviteFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InviteInitial || event.isSearching) {
          yield* _getUsersOnInitialState(query: event.query);
        }
        if (currentState is InviteSuccess) {
          yield* _getUsersOnSuccessState(currentState,
              query: event.query, isSearching: event.isSearching);
        }
      } catch (e) {
        print(e);
        // yield InviteFailure();
      }
    }

    if (event is InviteReseted) {
      yield InviteInitial();
    }
  }

  Stream<InviteState> _getUsersOnInitialState(
      {String query, bool isSearching}) async* {
    try {
      final initialPage = 1;
      final result = await _fetchUsersAndGetPages(initialPage, query: query);
      final users = result['users'];
      yield InviteSuccess(
          users: users,
          currentPage: result['currentPage'],
          lastPage: result['lastPage'],
          hasReachedMax: false);
    } catch (e) {
      print(e);
      // yield InviteFailure();
    }
  }

  /// Takes the current state of the bloc, check if the nextPage (`currentState.currentPage + 1`) is beyond
  /// the lastPage (`nextPage > currentState.lastPage`). if it is setState to hasReachedMax
  /// else get the requested users and set in state
  Stream<InviteState> _getUsersOnSuccessState(currentState,
      {String query, bool isSearching}) async* {
    try {
      int nextPage = currentState.currentPage + 1;

      if (isSearching == false) {
        if (nextPage > currentState.lastPage) {
          yield currentState.copyWith(hasReachedMax: true);
          return;
        }
      }

      if (isSearching) {
        nextPage = 1;
      }

      final result = await _fetchUsersAndGetPages(nextPage, query: query);
      if (result == null) {
        return;
      }
      final users = result['users'];
      yield InviteSuccess(
        users: isSearching ? users : currentState.users + users,
        currentPage: result['currentPage'],
        lastPage: result['lastPage'],
        hasReachedMax: false,
      );
    } catch (e) {
      print(e);
      // yield InviteFailure();
    }
  }

  bool _hasReachedMax(InviteState state) =>
      state is InviteSuccess && state.hasReachedMax;

  Future<Map<String, dynamic>> _fetchUsersAndGetPages(nextPage,
      {String query}) async {
    try {
      final usersList = [
        1,
        2,
        3,
        4,
        5,
        6,
        7
      ]; // fake list(will be replaced by api response)
      final users = _users(usersList);

      final int currentPage = 1;
      final int lastPage = 3;
      return {'users': users, 'currentPage': currentPage, 'lastPage': lastPage};
    } catch (e) {
      print(e);
      throw Exception('error fetching users');
    }
  }

  List _users(users) {
    return users.map((rawDetail) {
      return User(
          id: 1,
          username: 'User',
          email: 'username@gmail.com',
          profileImage: 'http://...',
          gender: 'Male',
          city: 'Portugal');
    }).toList();
  }
}
