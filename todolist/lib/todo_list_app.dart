import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/tasks_provider.dart';
import 'providers/user_provider.dart';
import 'services/auth_service.dart';
import 'screens/signin.dart';
import 'screens/tasks_master.dart';
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
        home: FutureBuilder<Map<String, dynamic>?>(
          future: AuthService().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                final user = User.fromJson(snapshot.data!);
                Provider.of<UserProvider>(context, listen: false).setUser(user);
              });
              return TaskMaster();
            } else {
              return SignIn();
            }
          },
        ),
      ),
    );
  }
}
