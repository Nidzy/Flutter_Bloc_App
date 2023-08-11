import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/bloc/user_bloc.dart';
import 'package:flutter_bloc_app/bloc/user_event.dart';
import 'package:flutter_bloc_app/bloc/user_state.dart';
import 'package:flutter_bloc_app/detail.dart';
import 'package:flutter_bloc_app/models/user_model.dart';
import 'package:flutter_bloc_app/repos/repositories.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
          create: (context) => UserRepositories(),
          child: const Home(
            title: 'Bloc App',
          )),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(RepositoryProvider.of<UserRepositories>(context),)..add(LoadUserEvent()),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
                title: const Text(
              "The Bloc App",style: TextStyle(color: Colors.white),
            )),
            body: BlocBuilder<UserBloc, UserState>
              (builder: (context, state) {
              if (state is UserLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if(state is UserLoadedState){
                List<UserModel> userList = state.users;
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_,index){
                      return listItem(context, userList, index);
                    });
              }

              if(state is UserErrorLoadingState){
                return const Center(child:Text("Error"));
              }

              return Container();
            })));
  }

  Padding listItem(BuildContext context, List<UserModel> userList, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                e: userList[index],
              ),
            ),
          );
        },
        child: Card(
          color: Colors.black,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(userList[index].firstName, style: const TextStyle(
                color: Colors.white,fontSize: 18.0
            ),),
            subtitle: Text(userList[index].lastName, style: const TextStyle(
                color: Colors.white, fontSize: 15.0
            )),
            trailing: CircleAvatar(
              backgroundImage: NetworkImage(userList[index].avatar),
            ),
          ),
        ),
      ),
    );
  }
}
