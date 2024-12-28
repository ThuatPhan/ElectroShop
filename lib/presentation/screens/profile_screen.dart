import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:electro_shop/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  GetIt.instance<AuthCubit>(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if(state is UnAuthenticated) {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  await context.read<AuthCubit>().login();
                },
                child: const Text("Đăng nhập"),
              ),
            );
          } else if (state is Authenticated) {
            final UserProfile userProfile = state.credentials.user;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfile.pictureUrl.toString()),
                    ),
                    Text("${userProfile.email}"),
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().logout();
                      },
                      child: const Text("Đăng xuất"),
                    )
                  ],
                )
              ],
            );
          } else if (state is AuthenticatedError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
