import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/room/room_invite/bloc.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/widgets/page_title.dart';
import 'package:test_app/widgets/search.dart';
import 'package:test_app/widgets/user_invite.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom>
    with SingleTickerProviderStateMixin {
  bool pressAttention = true;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  InviteBloc _inviteBloc;
  final List<User> invitedUsers = [];
  String query;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _inviteBloc = BlocProvider.of<InviteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteBloc, InviteState>(
        builder: (blocContext, state) {
          List _users = [];
          if (state is InviteSuccess) {
            _users = state.props[0];
          }
          print('show state');
          print(state);
        return Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    title: PageTitle(
                        title: 'New Group',
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CircularStd',
                          fontWeight: FontWeight.w700,
                          fontSize: 19.0,
                        )),
                    actions: <Widget>[
                      Row(
                        children: <Widget>[
                          invitedUsers.isNotEmpty
                              ? GestureDetector(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, top: 10, bottom: 10),
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontFamily: 'CircularStd',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    
                                  },
                                )
                              : Container(),
                          SizedBox(width: 15)
                        ],
                      ),
                    ],
                  ),
                ];
              },
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SearchInput(
                        placeHolderText: 'Search for people to invite',
                        onChange: (text) {
                          if (text.length > 0) {
                            setState(() => query = text);
                            _inviteBloc.add(
                                InviteFetched(query: query, isSearching: true));
                          }
                        }),
                    state is InviteSuccess
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            itemCount: _users.length,
                            itemBuilder: (BuildContext context, int index) {
                              User _userDetails = _users[index];
                              return UserInviteWidget(
                                      userDetails: _userDetails,
                                      onInvite: (user) => _inviteUser(user));
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
  });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (query != null && query.length > 0) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        _inviteBloc.add(InviteFetched(isSearching: false, query: query));
      }
    }
  }

  void _inviteUser(user) {
    setState(() {
      user.isInvited ? invitedUsers.remove(user) : invitedUsers.add(user);
      user.isInvited = !user.isInvited;
    });
  }
}