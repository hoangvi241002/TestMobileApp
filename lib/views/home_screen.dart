import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_test/view_models/login_bloc.dart';
import '../view_models/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger initial loading of items
    BlocProvider.of<HomeBloc>(context).refresh();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          const Text("Log Out"),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).loadMore();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Load More', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    );
                  }
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(state.items[index]),
                      leading: const Icon(Icons.check_circle, color: Colors.blueAccent),
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                  );
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
