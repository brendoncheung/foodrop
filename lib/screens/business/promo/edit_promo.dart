import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrop/core/models/promo.dart';
import 'package:foodrop/screens/common_widgets/date_time_picker.dart';
import 'package:provider/provider.dart';

import 'promo_period_date_time_picker.dart';

class EditPromo extends StatefulWidget {
  EditPromo({@required this.promoModel});
  PromoModel promoModel;

  static show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<PromoModel>(
          create: (context) => PromoModel(),
          child: Consumer<PromoModel>(
            builder: (_, model, __) => EditPromo(
              promoModel: model,
            ),
          ),
        ),
      ),
    );
  }

  // static Future<void> show(BuildContext context,
  //     {Database database, Job job}) async {
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => EditJobPage(database: database, job: job),
  //       fullscreenDialog: true,
  //     ),
  //   );
  // }

  @override
  _EditPromoState createState() => _EditPromoState();
}

class _EditPromoState extends State<EditPromo> {
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;

  // bool _mon = false;
  // bool _tue = false;
  // bool _wed = false;
  // bool _thu = false;
  // bool _fri = false;
  // bool _sat = false;
  // bool _sun = false;
  String _selectedDays = "";
  // bool hasPassCode = false;
  // String passCode = "";
  bool _takeAwayOnly = false;
  // Benefits _selectedBenefit = Benefits.FlatFee;

  PromoModel get _model => widget.promoModel;

  TextEditingController _promoNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _passcodeController = TextEditingController();
  TextEditingController _minimumSpendingController = TextEditingController();
  TextEditingController _flatFeeController = TextEditingController();
  TextEditingController _percDiscountController = TextEditingController();
  TextEditingController _freebieController = TextEditingController();
  TextEditingController _otherBenefitController = TextEditingController();

  FocusNode _promoNameFocusNode = FocusNode();
  FocusNode _descriptionFocusNode = FocusNode();
  FocusNode _passcodeFocusNode = FocusNode();
  FocusNode _minimumSpendFocusNode = FocusNode();
  FocusNode _flatFeeFocusNode = FocusNode();
  FocusNode _percDiscountFocusNode = FocusNode();
  FocusNode _freebieFocusNode = FocusNode();
  FocusNode _otherBenefitFocusNode = FocusNode();

  bool nonFormStateValidator = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // final start = widget.entry?.start ?? DateTime.now();
    final start = DateTime.now();
    _startDate = DateTime(start.year, start.month, start.day);
    _startTime = TimeOfDay.fromDateTime(start);

    // final end = widget.entry?.end ?? DateTime.now();
    final end = DateTime.now();
    _endDate = DateTime(end.year, end.month, end.day);
    _endTime = TimeOfDay.fromDateTime(end);

    // _comment = widget.entry?.comment ?? '';
  }

  // _switchListTileOnChange(value) {
  //   // setState(() {
  //   //   // _takeAwayOnly = value;
  //   // });
  // }

  TextFormField _buildMinimumSpendField() {
    return TextFormField(
      controller: _minimumSpendingController,
      focusNode: _minimumSpendFocusNode,
      decoration: InputDecoration(
        labelText: "Minimum spending",
        prefixText: "\$ ",
      ),
      keyboardType: TextInputType.number,
      validator: (value) => _model.numberNonNegativeValidator(value),
      onSaved: (value) {
        // update model
        _model.updateWith(restrictionMinPurchase: double.tryParse(value));
      },
    );
  }

  // onSave
  ListTile _buildSelectDays() {
    return ListTile(
      title: _selectedDays == ""
          ? Align(
              child: Text("Select days"),
              alignment: Alignment(-1.15, 0),
            )
          : Align(
              child: Text("Selected days"),
              alignment: Alignment(
                -1.15,
                0,
              )),
      subtitle: _selectedDays == ""
          ? Align(
              child: Text("Please select the day that applies"),
              alignment: Alignment(-1.35, 0),
            )
          : Align(
              child: Text(_selectedDays),
              alignment: Alignment(-1.15, 0),
            ),
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PromoPeriodDateTimePicker(
            daysSelected: (data) => _daysConfirmed(data),
          ),
        ),
      ),
      minLeadingWidth: 0.0,
    );
  }

// onSave
  _daysConfirmed(data) {
    // _model.promoMonday = data['mon'] ?? false;
    // _model.promoTuesday = data['tue'] ?? false;
    // _model.promoWednesday = data['wed'] ?? false;
    // _model.promoThursday = data['thu'] ?? false;
    // _model.promoFriday = data['fri'] ?? false;
    // _model.promoSaturday = data['sat'] ?? false;
    // _model.promoSunday = data['sun'] ?? false;

    _model.updateWith(
      promoMonday: data['mon'] ?? false,
      promoTuesday: data['tue'] ?? false,
      promoWednesday: data['wed'] ?? false,
      promoThursday: data['thu'] ?? false,
      promoFriday: data['fri'] ?? false,
      promoSaturday: data['sat'] ?? false,
      promoSunday: data['sun'] ?? false,
    );
    _model.updateWith(
        promoEveryDay: _model.promoMonday &&
                _model.promoTuesday &&
                _model.promoWednesday &&
                _model.promoThursday &&
                _model.promoFriday &&
                _model.promoSaturday &&
                _model.promoSunday
            ? true
            : false);
    // _model.updateWith(
    //     promoEveryDay: _model.promoMonday &&
    //             _model.promoTuesday &&
    //             _model.promoWednesday &&
    //             _model.promoThursday &&
    //             _model.promoFriday &&
    //             _model.promoSaturday &&
    //             _model.promoSunday
    //         ? true
    //         : false);

    _selectedDays = "";
    _selectedDays =
        _model.promoMonday ? "$_selectedDays Mon " : "$_selectedDays";
    _selectedDays =
        _model.promoTuesday ? "$_selectedDays Tue " : "$_selectedDays";
    _selectedDays =
        _model.promoWednesday ? "$_selectedDays Wed " : "$_selectedDays";
    _selectedDays =
        _model.promoThursday ? "$_selectedDays Thu " : "$_selectedDays";
    _selectedDays =
        _model.promoFriday ? "$_selectedDays Fri " : "$_selectedDays";
    _selectedDays =
        _model.promoSaturday ? "$_selectedDays Sat " : "$_selectedDays";
    _selectedDays =
        _model.promoSunday ? "$_selectedDays Sun " : "$_selectedDays";
  }

  // validation - completed
  // onSave - completed
  TextFormField _buildPromoNameField() {
    return TextFormField(
      controller: _promoNameController,
      focusNode: _promoNameFocusNode,
      decoration: InputDecoration(
        labelText: "Enter Promotion Name",
      ),
      validator: (value) => _model.nameValidator(value),
      onSaved: (value) => _model.updateWith(promoName: value),
    );
  }

  Widget _buildStartDate() {
    return DateTimePicker(
      labelText: 'Start',
      selectedDate: _startDate,
      selectedTime: _startTime,
      onSelectedDate: (date) => setState(() => _startDate = date),
      onSelectedTime: (time) => setState(() => _startTime = time),
    );
  }

  Widget _buildEndDate() {
    return DateTimePicker(
      labelText: 'End',
      selectedDate: _endDate,
      selectedTime: _endTime,
      onSelectedDate: (date) => setState(() => _endDate = date),
      onSelectedTime: (time) => setState(() => _endTime = time),
    );
  }

  // onSave implemented
  SwitchListTile _buildTakeAwayOnly() {
    return SwitchListTile(
      value: _takeAwayOnly,
      onChanged: (value) {
        // update bool variable
        _takeAwayOnly = value;
        // update model and refresh build
        _model.updateWith(
            restrictionDeliveryMethod: value
                ? DeliveryMethod.PickUpInStoreOnly
                : DeliveryMethod.NoRestrictions);
      },
      title: Align(
        child: Text("Takeaway Only"),
        alignment: Alignment(-1.2, 0),
      ),
      // subtitle: Text("Testing"),
    );
  }

  // validation - completed
  // onSave - completed
  TextFormField _buildPassCode() {
    return TextFormField(
        controller: _passcodeController,
        focusNode: _passcodeFocusNode,
        decoration: InputDecoration(
          labelText: "Set passcode and make it private",
        ),
        validator: (value) => _model.passcodeValidator(value),
        onSaved: (value) {
          print("passcode is $value");
          if (value != "" && value.length > 0) {
            _model.updateWith(hasPassCode: true, restrictionPassCode: value);
          } else {
            _model.updateWith(hasPassCode: false, restrictionPassCode: "");
          }
        });
  }

  Widget _buildBenefits() {
    return Column(
      children: [
        RadioListTile<Benefits>(
            toggleable: true,
            groupValue: _model.selectedBenefit,
            value: Benefits.FlatFee,
            title: TextFormField(
                controller: _flatFeeController,
                focusNode: _flatFeeFocusNode,
                validator: (value) => _model.numberNonNegativeValidator(value),
                onSaved: (value) =>
                    _model.updateWith(flatFee: double.tryParse(value) ?? 0),
                decoration: InputDecoration(
                  labelText: "Flat Fee",
                ),
                onTap: () {
                  _model.updateWith(selectedBenefits: Benefits.FlatFee);

                  // setState(() {
                  //   _selectedBenefit = Benefits.FlatFee;
                  // });
                }),
            // subtitle: Text("For all or selected items"),
            selectedTileColor: Colors.amber,
            selected: _model.selectedBenefit == Benefits.FlatFee,
            // tileColor: Colors.lightGreenAccent,
            onChanged: (value) {
              _model.updateWith(selectedBenefits: value);
              setState(() {});
            }),
        RadioListTile<Benefits>(
            toggleable: true,
            groupValue: _model.selectedBenefit,
            value: Benefits.PercentageDiscount,
            title: TextFormField(
                controller: _percDiscountController,
                focusNode: _percDiscountFocusNode,
                validator: (value) => _model.discountPercentValidator(value),
                onSaved: (value) => _model.updateWith(
                    benefitDiscount: true,
                    discountPercentage: double.tryParse(value) / 100),
                decoration: InputDecoration(
                  labelText: "Percentage Discount",
                ),
                onTap: () {
                  _model.updateWith(
                      selectedBenefits: Benefits.PercentageDiscount);
                  // setState(() {
                  //   _selectedBenefit = Benefits.PercentageDiscount;
                  // });
                }),
            selectedTileColor: Colors.amber,
            selected: _model.selectedBenefit == Benefits.PercentageDiscount,
            onChanged: (value) {
              _model.updateWith(selectedBenefits: value);
              // setState(() {
              //   _selectedBenefit = value;
              // });
            }),
        RadioListTile<Benefits>(
            toggleable: true,
            groupValue: _model.selectedBenefit,
            value: Benefits.Other,
            title: TextFormField(
                controller: _otherBenefitController,
                focusNode: _otherBenefitFocusNode,
                onSaved: (value) => _model.updateWith(
                    benefitOther: true, benefitOtherDescription: value),
                decoration: InputDecoration(
                  labelText: "Other",
                ),
                onTap: () {
                  _model.updateWith(selectedBenefits: Benefits.Other);
                  // setState(() {
                  //   _selectedBenefit = Benefits.Other;
                  // });
                }),
            // subtitle: Text("For all or selected items"),
            selectedTileColor: Colors.amber,
            selected: _model.selectedBenefit == Benefits.Other,

            // tileColor: Colors.lightGreenAccent,
            onChanged: (value) {
              _model.updateWith(selectedBenefits: value);
              // setState(() {
              //   _selectedBenefit = value;
              // });
            }),
      ],
    );
  }

  // onSave
  _launchPromo() {
    // final id = widget.entry?.id ?? documentIdFromCurrentDate();

    // update model with start and end promo datetime
    _model.updateWith(
        promoStartingDateTime: DateTime(_startDate.year, _startDate.month,
            _startDate.day, _startTime.hour, _startTime.minute),
        promoEndingDateTime: DateTime(_endDate.year, _endDate.month,
            _endDate.day, _endTime.hour, _endTime.minute));

    if (_model.promoStartingDateTime.isBefore(_model.promoEndingDateTime)) {
      nonFormStateValidator = true;
    } else {
      nonFormStateValidator = false;
    }

    if (_formKey.currentState.validate() && nonFormStateValidator) {
      // _startDate
      _formKey.currentState.save();
      // submit to DB
      print(_model);
    }
  }

  Align _buildLaunchButton() {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => _launchPromo(),
        child: Text("Launch Promotion"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Promo"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPromoNameField(),
                  _buildPromoDescription(),
                  _buildPassCode(),
                  _buildStartDate(),
                  _buildEndDate(),
                  SizedBox(
                    height: 8,
                  ),
                  _buildSelectDays(),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Specify terms and conditions"),
                  _buildMinimumSpendField(),
                  _buildTakeAwayOnly(),
                  Text("Select one the benefits"),
                  _buildBenefits(),
                  SizedBox(height: 8),
                  _buildLaunchButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPromoDescription() {
    return TextFormField(
      controller: _descriptionController,
      focusNode: _descriptionFocusNode,
      decoration: InputDecoration(
        labelText: "Please describe your promotion",
      ),
      validator: (value) => _model.nameValidator(value),
      onSaved: (value) => _model.updateWith(promoDescription: value),
    );
  }
}

// Navigator.of(context).push(
// MaterialPageRoute
