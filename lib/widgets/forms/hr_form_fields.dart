import 'package:flutter/material.dart';

Widget buildHrFormFields(Function onSave) {
  // Define controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  return Column(
    children: [
      // Employee Name Field
      TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'Employee Name',
          hintText: 'Enter employee name',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the employee name';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),

      // Department Field
      TextFormField(
        controller: departmentController,
        decoration: const InputDecoration(
          labelText: 'Department',
          hintText: 'Enter department',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the department';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),

      // Position Field
      TextFormField(
        controller: positionController,
        decoration: const InputDecoration(
          labelText: 'Position',
          hintText: 'Enter position',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the position';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),

      // Salary Field
      TextFormField(
        controller: salaryController,
        decoration: const InputDecoration(
          labelText: 'Salary',
          hintText: 'Enter salary',
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the salary';
          }
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
      const SizedBox(height: 24),

      // Save Button
      ElevatedButton(
        onPressed: () {
          // Validate and save the form data
          if (nameController.text.isNotEmpty &&
              departmentController.text.isNotEmpty &&
              positionController.text.isNotEmpty &&
              salaryController.text.isNotEmpty) {
            // Perform save action (e.g., save to database or state)
            final hrData = {
              'name': nameController.text,
              'department': departmentController.text,
              'position': positionController.text,
              'salary': double.parse(salaryController.text),
            };
            print('HR Data: $hrData'); // For debugging
            onSave(); // Close the modal
          }
        },
        child: const Text('Save'),
      ),
    ],
  );
}