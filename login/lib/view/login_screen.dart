import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:login/authcontroller/auth_controller.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(duration: const Duration(seconds: 1), child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(duration: const Duration(milliseconds: 1200), child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(duration: const Duration(milliseconds: 1300), child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      child: FadeInUp(duration: const Duration(milliseconds: 1600), child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                       // Text('Username', style: TextStyle(fontWeight: FontWeight.bold),)
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                             border: const OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color:Colors.black,
                                   width: 1,
                                 ),
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                             ),
                             // border: InputBorder.none,
                              hintText: "Email or Username",
                              hintStyle: TextStyle(color: Colors.grey[700]),
                               label: const Text('Username'),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                             border: const OutlineInputBorder(
                               borderSide: BorderSide(
                                 color:Colors.black,
                                 width: 1,
                               ),
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                             ),

                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[700]),
                            label: const Text('password'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30,),
                    FadeInUp(duration: const Duration(milliseconds: 1900), child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child:  Center(
                        child: TextButton(onPressed: () async {
                          try {
                            await Provider.of<AuthController>(context, listen: false).login(
                              usernameController.text,
                              passwordController.text,
                            );
                            Navigator.pushNamed(context, '/scanner', );
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(error.toString()),
                            ));
                          }
                          Navigator.pushNamed(context, '/scanner', );
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                      ),
                    )),
                    const SizedBox(height: 70,),
                    FadeInUp(duration: const Duration(milliseconds: 2000), child: const Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
