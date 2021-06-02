import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:provider/provider.dart';

import '../../core/models/UserProfile/UserProfile.dart';
import '../common_widgets/form_submit_button.dart';
import '../common_widgets/show_exception_alert_dialog.dart';

class EmailSignInFormUserProfileChangeNotifier extends StatefulWidget {
  EmailSignInFormUserProfileChangeNotifier(
      {@required this.model, this.onLoggedIn});
  final UserProfile model;
  VoidCallback onLoggedIn;

  static Widget create(BuildContext context, VoidCallback onLoggedIn) {
    print("****** recreate Sign In Form ******");
    final auth = Provider.of<AuthenticationService>(context, listen: false);
    return ChangeNotifierProvider<UserProfile>(
      create: (_) => UserProfile(auth: auth),
      child: Consumer<UserProfile>(
        builder: (_, model, __) => EmailSignInFormUserProfileChangeNotifier(
            model: model, onLoggedIn: onLoggedIn),
      ),
    );
  }

  @override
  _EmailSignInFormUserProfileChangeNotifier createState() =>
      _EmailSignInFormUserProfileChangeNotifier();
}

class _EmailSignInFormUserProfileChangeNotifier
    extends State<EmailSignInFormUserProfileChangeNotifier> {
  final TextEditingController _tecFirstName = TextEditingController();
  final TextEditingController _tecLastName = TextEditingController();
  final TextEditingController _tecUserName = TextEditingController();
  final TextEditingController _tecMobileNumber = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _fnFirstName = FocusNode();
  final FocusNode _fnLastName = FocusNode();
  final FocusNode _fnUserName = FocusNode();
  final FocusNode _fnMobileNumber = FocusNode();
  final FocusNode _fnEmail = FocusNode();
  final FocusNode _fnPassword = FocusNode();

  UserProfile get model => widget.model;

  @override
  void dispose() {
    _tecFirstName.dispose();
    _tecLastName.dispose();
    _tecUserName.dispose();
    _tecMobileNumber.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fnFirstName.dispose();
    _fnLastName.dispose();
    _fnUserName.dispose();
    _fnMobileNumber.dispose();
    _fnEmail.dispose();
    _fnPassword.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    try {
      // user logged in, trigger onAuthStateChanges
      await model.submit();
      if (model.formType == EmailSignInFormType.register) {
        final db = FirestoreDatabase(uid: model.uid);
        await db.setUser(model);
      }
      print("signed in attempted");
      widget.onLoggedIn();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  TextField _buildFirstNameTextField() {
    print(_tecFirstName.text);
    return TextField(
      controller: _tecFirstName,
      focusNode: _fnFirstName,
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'John',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      // keyboardType: TextInputType,
      textInputAction: TextInputAction.next,
      onChanged: model.updateFirstName,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_fnLastName),
    );
  }

  TextField _buildLastNameTextField() {
    return TextField(
      controller: _tecLastName,
      focusNode: _fnLastName,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Smith',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      // keyboardType: TextInputType,
      textInputAction: TextInputAction.next,
      onChanged: model.updateLastName,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_fnUserName),
    );
  }

  TextField _buildUserNameTextField() {
    return TextField(
      controller: _tecUserName,
      focusNode: _fnUserName,
      decoration: InputDecoration(
        labelText: 'Preferred Name',
        hintText: 'Dark Vader',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      // keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateUserName,
      onEditingComplete: () =>
          FocusScope.of(context).requestFocus(_fnMobileNumber),
    );
  }

  TextField _buildMobileNumberField() {
    return TextField(
      controller: _tecMobileNumber,
      focusNode: _fnMobileNumber,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: '022-22222222',
        errorText: model.nonEmptyText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: model.updateMobileNumber,
      onEditingComplete: () => FocusScope.of(context).requestFocus(_fnEmail),
    );
  }

  TextField _buildEmailTextField() {
    // print(_emailController.text);
    return TextField(
      controller: _emailController,
      focusNode: _fnEmail,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => model.updateWith(emailAddress: email),
      onEditingComplete: () => FocusScope.of(context).requestFocus(_fnPassword),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _fnPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (pw) => model.updateWith(emailPassword: pw),
      onEditingComplete: _submit,
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
      if (model.formType == EmailSignInFormType.register)
        ..._registeringFields(),
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

  List<Widget> _registeringFields() {
    return [
      CircleAvatar(
        child: Icon(Icons.person),
      ),
      _buildFirstNameTextField(),
      SizedBox(height: 8.0),
      _buildLastNameTextField(),
      SizedBox(height: 8.0),
      _buildUserNameTextField(),
      SizedBox(height: 8.0),
      _buildMobileNumberField(),
      SizedBox(height: 8.0),
    ];
  }
}
