import 'dart:io';

import 'package:favorite_places_app_5/models/place.dart';
import 'package:favorite_places_app_5/providers/user_places.dart';
import 'package:favorite_places_app_5/widgets/image_input.dart';
import 'package:favorite_places_app_5/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    if (_formKey.currentState!.validate() ||
        _selectedImage == null ||
        _selectedLocation == null) {
      _formKey.currentState!.save();
      ref.read(userPlacesProvider.notifier).addPlace(
            Place(
                title: _enteredTitle,
                image: _selectedImage!,
                location: _selectedLocation!),
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return "Must be between 1 and 50 charcters.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                onPickImage: (File image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              LocationInput(
                onSelectLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _savePlace();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Place"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
