import 'package:flutter/material.dart';
import '../models/auth_form_model.dart';
import '../widgets/auth_form_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormModel formModel) async {
    try {
      setState(() => _isLoading = true);

      if (formModel.isLogin) {
        // Login
      } else {
        // Signup
      }
    } catch (e) {
      // Tratar error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: AuthFormWidget(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
