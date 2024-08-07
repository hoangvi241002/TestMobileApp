import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_test/view_models/login_bloc.dart';
import '../view_models/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<HomeBloc>(context).refresh();
              },
              child: ListView.builder(
                itemCount: state.items.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).loadMore();
                      },
                      child: const Text('Load More'),
                    );
                  }
                  return ListTile(title: Text(state.items[index]));
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
