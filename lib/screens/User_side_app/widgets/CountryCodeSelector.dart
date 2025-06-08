import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class CountryCodeSelector extends StatefulWidget {
  const CountryCodeSelector({Key? key}) : super(key: key);

  @override
  _CountryCodeSelectorState createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  final phoneController = TextEditingController();
  var _currentSelectedCountry =
      const CountryWithPhoneCode.us(); // Default country

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: 'Phone Number',
          hintText: '+${_currentSelectedCountry.phoneCode} Enter phone number',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () async {
              final sortedCountries = CountryManager()
                ..countries.sort(
                  (a, b) =>
                      (a.countryName ?? '').compareTo(b.countryName ?? ''),
                );

              final res = await showModalBottomSheet<CountryWithPhoneCode>(
                context: context,
                isScrollControlled: false,
                builder: (context) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: sortedCountries.countries.length,
                    itemBuilder: (context, index) {
                      final item = sortedCountries.countries[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.of(context).pop(item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              // Display country phone code
                              Expanded(
                                child: Text(
                                  '+${item.phoneCode}',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Display country name
                              Expanded(
                                flex: 8,
                                child: Text(
                                  item.countryName ?? '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );

              if (res != null) {
                setState(() {
                  _currentSelectedCountry = res;
                  phoneController.text =
                      '+${res.phoneCode} '; // Update phone number field with selected country code
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
