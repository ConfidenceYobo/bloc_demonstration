import 'package:equatable/equatable.dart';

abstract class InviteState extends Equatable {
  const InviteState():super();

  @override
  List<Object> get props => [];
}

class InviteInitial extends InviteState {}

class InviteFailure extends InviteState {}

class InviteSuccess extends InviteState {
  final List users;
  final bool hasReachedMax;
  final int currentPage;

  ///integer that represents the last page of the pagination
  final int lastPage;

  const InviteSuccess({
    this.users,
    this.hasReachedMax,
    this.currentPage,
    this.lastPage
  });

  InviteSuccess copyWith({
    List users,
    bool hasReachedMax,
    int currentPage,
    int lastPage
  }) {
    return InviteSuccess(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object> get props => [users, hasReachedMax];

  @override
  String toString() =>
      'InviteSuccess { rooms: ${users.length}, hasReachedMax: $hasReachedMax }';
}
