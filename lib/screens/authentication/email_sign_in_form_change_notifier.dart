import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:provider/provider.dart';

import '../common_widgets/form_submit_button.dart';
import '../common_widgets/show_exception_alert_dialog.dart';
import 'email_sign_in_change_model.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthenticationService>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isNotEmpty(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.updatePassword,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextEditingController _tecFullName = TextEditingController();
  TextEditingController _tecPreferredName = TextEditingController();
  TextEditingController _tecPhoneNumber = TextEditingController();
  FocusNode _fnFullName = FocusNode();
  FocusNode _fnPreferredName = FocusNode();
  FocusNode _fnPhoneNumber = FocusNode();

  TextField _buildFullNameTextField() {
    return TextField(
      controller: _tecFullName,
      focusNode: _fnFullName,
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'John Smith',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      // keyboardType: TextInputType,
      textInputAction: TextInputAction.next,
      onChanged: model.updateFullName,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPreferredNameTextField() {
    return TextField(
      controller: _tecPreferredName,
      focusNode: _fnPreferredName,
      decoration: InputDecoration(
        labelText: 'Preferred Name',
        hintText: 'Dark Vader',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      // keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePreferredName,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPhoneNumberField() {
    return TextField(
      controller: _tecPhoneNumber,
      focusNode: _fnPhoneNumber,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: '022-22222222',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePhoneNumber,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      TextButton(onPressed: () {}, child: Text("")),
      _buildFullNameTextField(),
      SizedBox(height: 8.0),
      _buildPreferredNameTextField(),
      SizedBox(height: 8.0),
      _buildPhoneNumberField(),
      SizedBox(height: 8.0),
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }
}
