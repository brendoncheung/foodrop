import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodrop/core/authentication/authentication_service.dart';
import 'package:foodrop/core/services/database.dart';
import 'package:foodrop/screens/common_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

import '../../core/models/UserProfile/UserProfile.dart';
import '../common_widgets/form_submit_button.dart';
import '../common_widgets/show_exception_alert_dialog.dart';

class EmailSignInFormUserProfileChangeNotifier extends StatefulWidget {
  EmailSignInFormUserProfileChangeNotifier({@required this.model, this.userUpdateProfileModel});
  final UserProfile model;
  // VoidCallback onLoggedIn;
  UserProfile userUpdateProfileModel;
  static Widget create({BuildContext context, UserProfile firebaseUserProfile}) {
    print("****** create Sign In Form ******");
    final auth = Provider.of<AuthenticationService>(context, listen: false);
    return ChangeNotifierProvider<UserProfile>(
      create: (_) => UserProfile(auth: auth),
      child: Consumer<UserProfile>(
        builder: (_, signInModel, __) => EmailSignInFormUserProfileChangeNotifier(model: signInModel, userUpdateProfileModel: firebaseUserProfile),
      ),
    );
  }

  @override
  _EmailSignInFormUserProfileChangeNotifier createState() => _EmailSignInFormUserProfileChangeNotifier();
}

class _EmailSignInFormUserProfileChangeNotifier extends State<EmailSignInFormUserProfileChangeNotifier> {
  var hasExistingUserProfile = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    print("run initState");
    try {
      if (widget.userUpdateProfileModel != null) {
        model.updateWith(
          uid: widget.userUpdateProfileModel.uid,
          firstName: widget.userUpdateProfileModel.firstName,
          lastName: widget.userUpdateProfileModel.lastName,
          username: widget.userUpdateProfileModel.username,
          mobileNumber: widget.userUpdateProfileModel.mobileNumber,
          emailAddress: widget.userUpdateProfileModel.emailAddress,
          photoUrl: widget.userUpdateProfileModel.photoUrl,
          formType: widget.userUpdateProfileModel.formType,
        );

        hasExistingUserProfile = true;
        widget.userUpdateProfileModel.updateWith(formType: EmailSignInFormType.update);
        _tecFirstName.text = widget.userUpdateProfileModel.firstName ?? "";
        _tecLastName.text = widget.userUpdateProfileModel.lastName ?? "";
        _tecUserName.text = widget.userUpdateProfileModel.username ?? "";
        _tecMobileNumber.text = widget.userUpdateProfileModel.mobileNumber ?? "";
        _emailController.text = widget.userUpdateProfileModel.emailAddress ?? "";
      }
    } catch (e) {
      print("userProfile from firebase not found");
    }
    super.initState();
  }

  final _ProfileSignInFormKey = GlobalKey<FormState>();

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
    if (hasExistingUserProfile) {
      // RUN UPDATE PROFILE
      try {
        final db1 = FirestoreDatabase(uid: model.uid);
        await db1.setUser(model);
        showAlertDialog(context, title: "User Profile", content: "Update Successful", defaultActionText: "OK");
        // Navigator.of(context).pop();
      } catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Update failed',
          exception: e,
        );
      }
    } else {
      try {
        _ProfileSignInFormKey.currentState.save();
        // print(model);
        await model.submit(); // this will sign in Or create new user then sign them in
        // if form type is register, store user details to firebase
        if (model.formType == EmailSignInFormType.register) {
          final db = FirestoreDatabase(uid: model.uid);
          await db.setUser(model);
        }
        // widget
        // .onLoggedIn(); // trigger setState at ProfileLandingPage and force it to rebuild.
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Sign in failed',
          exception: e,
        );
      }
    }
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  TextFormField _buildFirstNameTextField() {
    return TextFormField(
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
      onSaved: (text) => model.updateFirstName(text),
    );
  }

  TextFormField _buildLastNameTextField() {
    return TextFormField(
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
      onSaved: (text) => model.updateLastName(text),
    );
  }

  TextFormField _buildUserNameTextField() {
    return TextFormField(
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
      onEditingComplete: () => FocusScope.of(context).requestFocus(_fnMobileNumber),
      onSaved: (text) => model.updateUserName(text),
    );
  }

  TextFormField _buildMobileNumberField() {
    return TextFormField(
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
      onSaved: (text) => model.updateMobileNumber(text),
    );
  }

  TextFormField _buildEmailTextField() {
    return TextFormField(
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
        onSaved: (email) => model.updateWith(emailAddress: email));
  }

  TextFormField _buildPasswordTextField() {
    return TextFormField(
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
        onSaved: (pw) => model.updateWith(emailPassword: pw));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _ProfileSignInFormKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren() {
    // print(model.formType);
    return [
      if (model.formType == EmailSignInFormType.register || hasExistingUserProfile) ..._registeringFields(),
      _buildEmailTextField(),
      if (!hasExistingUserProfile) ..._showPassword(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: hasExistingUserProfile ? "Update Prgggofile" : model.primaryButtonText,
        onPressed: hasExistingUserProfile
            ? _submit
            : model.canSubmit
                ? _submit
                : null,
      ),
      SizedBox(height: 8.0),
      if (!hasExistingUserProfile)
        TextButton(
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

  List<Widget> _showPassword() {
    return [
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
    ];
  }
}
