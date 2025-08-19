import 'package:flutter/material.dart';
import 'package:meia_entrada/src/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/assets.dart';
import '../../../themes/colors.dart';
import 'types.dart';


class SignupForm extends StatefulWidget {
  final SignupCallback onPressedSignup;
  final VoidCallback? onPressedBackToLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;

  const SignupForm({
    super.key,
    required this.onPressedSignup,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    this.onPressedBackToLogin,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}



class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailField = FocusNode();
  final FocusNode _passwordField = FocusNode();

  String? _errorMessage; // <-- Add this line

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      try {
        await widget.onPressedSignup(
          widget.nameController.text,
          widget.emailController.text,
          widget.passwordController.text,
        );
        setState(() {
          _errorMessage = null;
        });
      } catch (e) {
        final errorMsg = e.toString();
        setState(() {
          _errorMessage = errorMsg;
        });
        // Show as popup
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMsg)),
        );
      }
    }
    // If validation fails, error messages will show automatically
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.logo,
            height: 80.0,
          ),
          const Text('Create account'),
          if (_errorMessage != null) // <-- Add this block
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          TextFormField(
            controller: widget.nameController,
            validator: (value) =>
                (value == null || value.isEmpty) ? l10n.nameValidationError : null,
            decoration: InputDecoration(
              label: Text(l10n.nameFieldLabel),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            key: const Key("email-field"),
            focusNode: _emailField,
            controller: widget.emailController,
            validator: (value) =>
                (value == null || value.isEmpty) ? l10n.emailValidationError : null,
            decoration: InputDecoration(
              label: Text(l10n.emailFieldlabel),
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            key: const Key("password-field"),
            focusNode: _passwordField,
            controller: widget.passwordController,
            obscureText: true,
            validator: (value) =>
                (value == null || value.isEmpty) ? l10n.passwordValidationError : null,
            onEditingComplete: _signup,
            decoration: InputDecoration(
              label: Text(l10n.passwordFieldLabel),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _signup,
            child: const Text('Create'),
          ),
          if (widget.onPressedBackToLogin != null) ...[
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(color: AppColors.primaryColor),
                      ),
                      label: const Text("Back to Login"),
                      onPressed: widget.onPressedBackToLogin,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}