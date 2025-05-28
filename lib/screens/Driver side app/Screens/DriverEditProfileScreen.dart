import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class DriverEditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;

  const DriverEditProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  _DriverEditProfileScreenState createState() =>
      _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.name);
    _emailCtrl = TextEditingController(text: widget.email);
    _phoneCtrl = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save profile to backend or local storage

      Navigator.pop(context, {
        'name': _nameCtrl.text,
        'email': _emailCtrl.text,
        'phone': _phoneCtrl.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white), // White text
        ),
        iconTheme: IconThemeData(color: Colors.white), // White icons
        backgroundColor: Constants.PRIMARY_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.profileImageUrl),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(_nameCtrl, 'Name', 'Enter your name'),
              SizedBox(height: 16),
              _buildTextField(
                _emailCtrl,
                'Email',
                'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null ||
                      val.isEmpty ||
                      !val.contains('@') ||
                      !val.contains('.')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildTextField(
                _phoneCtrl,
                'Phone',
                'Enter your phone number',
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.length < 7) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.PRIMARY_COLOR,
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController ctrl, String label, String placeholder,
      {TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator ??
          (val) {
            if (val == null || val.isEmpty) return 'Please enter $label';
            return null;
          },
    );
  }
}
