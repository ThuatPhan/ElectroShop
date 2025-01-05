import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:electro_shop/constants.dart';
import 'package:electro_shop/presentation/bloc/auth_cubit.dart';
import 'package:electro_shop/presentation/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  GetIt.instance<AuthCubit>(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if(state is UnAuthenticated) {
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              child: Container(
                                width: 69,
                                height: 69,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: const Icon(FontAwesomeIcons.userSecret),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await context.read<AuthCubit>().login();
                              },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )
                                ),
                              child: const Text("Đăng nhập")
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Người dùng',
                        style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/cart');
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                color: Colors.green
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(FontAwesomeIcons.cartShopping, color: Colors.white)
                                            )
                                        ),
                                        const SizedBox(width: 10),
                                        const Text("Giỏ hàng")
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.blue
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.clock, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Đơn hàng đã mua")
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.pink
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.heart, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Sản phẩm yêu thích")
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Hệ thống',
                        style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.cyan
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.message, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Phản hồi"),
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.blueAccent
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.solidMoon, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Chế độ tối"),
                                    ],
                                  ),
                                  Consumer<ThemeProvider>(
                                    builder: (context, themeProvider, _) => Switch(
                                      value: themeProvider.themeMode == ThemeMode.dark,
                                      onChanged: (value) {
                                        themeProvider.toggleTheme();
                                      },
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state is Authenticated) {
            final UserProfile userProfile = state.credentials.user;
            return Column(
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 30),
                        child: Row(
                          children: [
                            Card(
                              child: SizedBox(
                                height: 69,
                                width: 69,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(userProfile.pictureUrl.toString()),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                                "${userProfile.name}",
                                style: const TextStyle(
                                    fontSize: headerSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Người dùng',
                        style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.green
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.cartShopping, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Giỏ hàng")
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.blue
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.clock, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Đơn hàng đã mua")
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.pink
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.heart, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Sản phẩm yêu thích")
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Hệ thống',
                        style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.cyan
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.message, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Phản hồi"),
                                    ],
                                  ),
                                  const Icon(Icons.keyboard_arrow_right_outlined)
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: Colors.blueAccent
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(FontAwesomeIcons.solidMoon, color: Colors.white)
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      const Text("Chế độ tối"),
                                    ],
                                  ),
                                  Consumer<ThemeProvider>(
                                    builder: (context, themeProvider, _) => Switch(
                                      value: themeProvider.themeMode == ThemeMode.dark,
                                      onChanged: (value) {
                                        themeProvider.toggleTheme();
                                      },
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await context.read<AuthCubit>().logout();
                        },
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: Colors.red
                                        ),
                                        child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(FontAwesomeIcons.arrowRightFromBracket, color: Colors.white)
                                        )
                                    ),
                                    const SizedBox(width: 10),
                                    const Text("Đăng xuất"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (state is AuthenticatedError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(state.message))
             );
            });
          }
          return Container();
        },
      ),
    );
  }
}
