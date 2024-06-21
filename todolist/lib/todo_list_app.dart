import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tasks_provider.dart';
import 'providers/user_provider.dart';
import 'services/auth_service.dart';
import 'screens/signin.dart';
import 'screens/tasks_master.dart';
import 'screens/task_form.dart';
import 'models/user.dart';

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            buttonColor: Colors.blue,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => FutureBuilder<Map<String, dynamic>?>(
                future: AuthService().getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final user = User.fromJson(snapshot.data!);
                    Provider.of<UserProvider>(context, listen: false)
                        .setUser(user);
                    return TasksMaster();
                  } else {
                    return SignIn();
                  }
                },
              ),
          '/task_form': (context) => TaskForm(),
        },
      ),
    );
  }
}
