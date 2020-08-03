import 'package:equatable/equatable.dart';

abstract class InviteEvent extends Equatable {
  InviteEvent():super();
  @override
  List<Object> get props => [];
}

class InviteFetched extends InviteEvent {
  final String query;
  final bool isSearching;

  InviteFetched({this.query, this.isSearching});

  @override
  List<Object> get props => [query, isSearching];

  @override
  String toString() {
    return 'InviteFetched { query: $query, isSearching: $isSearching }';
  }
}
