import 'package:flutter/material.dart';
import 'package:netroll/bloc/user_bloc.dart';
import 'package:netroll/constants.dart';
import 'package:provider/provider.dart';

class HomeReq extends StatelessWidget {
  const HomeReq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<UsersBloc>(
      create: (context) => UsersBloc(),
      child: const HomeReqTemplate(),
      dispose: (context, value) => value.dispose(),
    );
  }
}

class HomeReqTemplate extends StatelessWidget {
  const HomeReqTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersBloc = Provider.of<UsersBloc>(context);

    usersBloc.stream.listen((resp) {
      print('stream listen');
      print(resp.message);
    });
    void onPressed() {
      print('pressed!!');
      usersBloc.fetch();
    }

    return Scaffold(
        backgroundColor: gradientEndColor,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: onPressed,
        ));
  }
}
