import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:githive/model/currency_model.dart';
import 'package:githive/views/cubit/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        var cubit = HomeCubit();
        cubit.getData();
        return cubit;
      },
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is HomeErrorState) {
              return Center(
                child: Text("error"),
              );
            } else if (state is HomeInitialState) {
              return Center(
                child: FlutterLogo(size: 45),
              );
            } else if (state is HomeComplateState) {
              List<CurrencyModel>? data = state.users;
              return ListView.builder(
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(""),
                    ),
                  );
                }),
              );
            } else {
              return Center(child: Image.asset("assets/gif/loading.gif"));
            }
          },
        ),
      ),
    );
  }
}
