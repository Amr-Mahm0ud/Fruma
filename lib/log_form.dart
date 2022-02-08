import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruma/main_page.dart';
import 'package:fruma/provider_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogForm extends StatefulWidget {
  const LogForm({Key? key}) : super(key: key);

  @override
  _LogFormState createState() => _LogFormState();
}

enum Auth { signIn, signUp }

class _LogFormState extends State<LogForm> with SingleTickerProviderStateMixin {
  Auth authMode = Auth.signIn;
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _visiblePass = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const MainPage()));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).canvasColor,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            spreadRadius: 5)
                      ]),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null ||
                                val.isEmpty ||
                                !val.contains('@') ||
                                !val.contains('.com')) {
                              return 'invalid E-Mail';
                            }
                            return null;
                          },
                          onSaved: (val) async {
                            Provider.of<MyProvider>(context, listen: false)
                                .addUserEmail(val!);
                            SharedPreferences _pref =
                                await SharedPreferences.getInstance();
                            _pref.setString('email', val);
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: password,
                          obscureText: _visiblePass,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                                icon: Icon(_visiblePass
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () => setState(
                                    () => _visiblePass = !_visiblePass)),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val == null || val.isEmpty || val.length < 8) {
                              return authMode == Auth.signIn
                                  ? 'Wrong Password'
                                  : 'Weak Password';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            if (authMode == Auth.signUp) {
                              _formKey.currentState!.validate();
                            }
                          },
                          onSaved: (val) async {
                            Provider.of<MyProvider>(context, listen: false)
                                .addUserPassword(val!);
                            SharedPreferences _pref =
                                await SharedPreferences.getInstance();
                            _pref.setString('email', val);
                          },
                        ),
                        const SizedBox(height: 15),
                        AnimatedContainer(
                          constraints: BoxConstraints(
                            minHeight: authMode == Auth.signIn ? 20 : 0,
                            maxHeight: authMode == Auth.signIn ? 35 : 0,
                          ),
                          duration: const Duration(milliseconds: 200),
                          child: TextButton(
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        AnimatedContainer(
                          height: authMode == Auth.signUp ? 100 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: authMode == Auth.signUp
                              ? TextFormField(
                                  obscureText: _visiblePass,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    prefixIcon: const Icon(Icons.lock_outlined),
                                    suffixIcon: IconButton(
                                        icon: Icon(_visiblePass
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () => setState(() =>
                                            _visiblePass = !_visiblePass)),
                                    hintText: 'Confirm password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    if (val == null ||
                                        val.isEmpty ||
                                        val != password.text) {
                                      return 'wrong password';
                                    }
                                    return null;
                                  },
                                  onChanged: (_) {
                                    _formKey.currentState!.validate();
                                  },
                                )
                              : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submit,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 7),
                            child: Text(
                              authMode == Auth.signIn ? 'Sign In' : 'Sign Up',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (authMode == Auth.signIn) {
                          authMode = Auth.signUp;
                        } else {
                          authMode = Auth.signIn;
                        }
                      });
                    },
                    child: Text(
                      authMode == Auth.signIn
                          ? 'Create account?'
                          : 'already have account?',
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
