import 'package:flutter/material.dart';
import 'package:netroll/bloc/user_bloc.dart';
import 'package:netroll/constants.dart';
import 'package:netroll/models/user.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test Request",
                  style: TextStyle(
                      color: primaryTextColor,
                      fontFamily: "Raleway",
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text("Req : $ENDPOINT",
                    style: TextStyle(
                      color: contentTextColor,
                    )),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Items',
                  style: TextStyle(
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: StreamBuilder<UserResponse>(
                      stream: usersBloc.stream,
                      builder: (context, snapshot) {
                        var data = snapshot.data;
                        if (snapshot.hasData == false ||
                            data == null ||
                            data.users.isEmpty) {
                          return Container();
                        } else {
                          return ListView.builder(
                            itemCount: data.users.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var user = data.users[index];

                              return  Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text('userid : ${user.userId}'),
                                    Text('firstname : ${user.firstname}'),
                                    Text('lastname : ${user.lastname}'),
                                    Text('friedns cnt : ${user.friends.length}')
                                  ],),
                                ) 
                              );
                            },
                          );
                        }
                      }),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        )),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: onPressed,
        ));
  }
}
