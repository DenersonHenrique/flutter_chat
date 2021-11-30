import 'package:flutter/material.dart';
import 'package:flutter_chat/app/modules/authentication/models/auth_form_model.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({Key? key}) : super(key: key);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _authFormModel = AuthFormModel();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            children: <Widget>[
              if (_authFormModel.isSignUp)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authFormModel.name,
                  onChanged: (name) => _authFormModel.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authFormModel.email,
                onChanged: (email) => _authFormModel.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                obscureText: true,
                key: const ValueKey('password'),
                initialValue: _authFormModel.password,
                onChanged: (password) => _authFormModel.password = password,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authFormModel.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                child: Text(
                  _authFormModel.isLogin ? 'Nova conta' : 'Possui conta?',
                ),
                onPressed: () => setState(
                  () {
                    _authFormModel.toggleAuthMode();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
