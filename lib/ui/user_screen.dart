import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_suplo/blocs/blocs.dart';
import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/routes.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Users'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () =>
                  BlocProvider.of<UserBloc>(context).add(GetUserEvent()),
            )
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is InitUserState || state is LoadingUser) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.users.length == 0) {
              return Center(child: Text('Users Empty!'),);
            }
            else {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return userItem(state.users[index]);
                },
              );
            }
          },
        ));
  }

  Widget userItem(User user) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.postScreen, arguments: user.id);
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                user.name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Divider(
            indent: 1,
          ),
        ],
      ),
    );
  }
}
