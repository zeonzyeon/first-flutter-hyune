import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User {
  String name;
  String address;
  User(this.name, this.address);
}

abstract class UserEvent {
  User user;
  UserEvent(this.user);
}

class CreateUserEvent extends UserEvent {
  CreateUserEvent(User user) : super(user);
}

class UpdateUserEvent extends UserEvent {
  UpdateUserEvent(User user) : super(user);
}

// UserBloc 정의
class UserBloc extends Bloc<UserEvent, User?> {
  UserBloc() : super(null) {
    on<CreateUserEvent>((event, emit) {
      emit(event.user);
    });

    on<UpdateUserEvent>((event, emit) {
      emit(event.user);
    });
  }
}

// CounterEvent 정의
abstract class CounterEvent {
  int no;
  CounterEvent(this.no);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent(int no) : super(no);
}

class DecrementEvent extends CounterEvent {
  DecrementEvent(int no) : super(no);
}

// BlocCounter 정의
class BlocCounter extends Bloc<CounterEvent, int> {
  BlocCounter() : super(0) {
    on<IncrementEvent>((event, emit) {
      emit(state + event.no);
    });

    on<DecrementEvent>((event, emit) {
      emit(state - event.no);
    });
  }
}

// MyBlocObserver 정의
class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('observer onTransition: $transition');
  }
}

void main() {
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('BLoC Example'),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BlocCounter()),
            BlocProvider(create: (context) => UserBloc()),
          ],
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocCounter counterBloc = BlocProvider.of<BlocCounter>(context);
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<BlocCounter, int>(
          listenWhen: (previous, current) => true,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$state'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
        BlocListener<UserBloc, User?>(
          listener: (context, user) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${user?.name}'),
                backgroundColor: Colors.blue,
              ),
            );
          },
        ),
      ],
      child: Container(
        color: Colors.deepOrange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<BlocCounter, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              BlocBuilder<UserBloc, User?>(
                builder: (context, user) {
                  return Text(
                    'User: ${user?.name}, ${user?.address}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  counterBloc.add(IncrementEvent(2));
                },
                child: Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  counterBloc.add(DecrementEvent(2));
                },
                child: Text('Decrement'),
              ),
              ElevatedButton(
                onPressed: () {
                  userBloc.add(CreateUserEvent(User('Kkang', 'Seoul')));
                },
                child: Text('Create'),
              ),
              ElevatedButton(
                onPressed: () {
                  userBloc.add(UpdateUserEvent(User('Kim', 'Busan')));
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
