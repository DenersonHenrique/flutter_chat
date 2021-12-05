import 'dart:io';
import 'user_image_picker_widget.dart';
import 'package:flutter/material.dart';
import '../models/auth_form_model.dart';
import '../../../constants/app_string.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(AuthFormModel) onSubmit;

  const AuthFormWidget({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _authFormModel = AuthFormModel();
  final _formKey = GlobalKey<FormState>();

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _handleImagePick(File image) {
    _authFormModel.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_authFormModel.image == null && _authFormModel.isSignUp) {
      return _showError('Imagem não selecionada.');
    }

    widget.onSubmit(_authFormModel);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              if (_authFormModel.isSignUp)
                UserImagePickerWidget(
                  onImagePick: _handleImagePick,
                ),
              if (_authFormModel.isSignUp)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authFormModel.name,
                  onChanged: (name) => _authFormModel.name = name,
                  decoration: InputDecoration(
                    labelText: AppString.nameTextFieldLabel,
                  ),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome, mínimo de 5 caracteres.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authFormModel.email,
                onChanged: (email) => _authFormModel.email = email,
                decoration: InputDecoration(
                  labelText: AppString.emailTextFieldLabel,
                ),
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.isEmpty || !email.contains('@')) {
                    return 'Informe um e-mail válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                key: const ValueKey('password'),
                initialValue: _authFormModel.password,
                onChanged: (password) => _authFormModel.password = password,
                decoration: InputDecoration(
                  labelText: AppString.passwordTextFieldLabel,
                ),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Senha, mínimo de 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authFormModel.isLogin
                      ? AppString.signInTextFieldLabel
                      : AppString.signUpTextFieldLabel,
                ),
              ),
              TextButton(
                child: Text(
                  _authFormModel.isLogin
                      ? AppString.newAccountTextFieldLabel
                      : AppString.oldAccountTextFieldLabel,
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
