import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../onboarding_page.dart';

class BirthDateStep extends StatefulWidget {
  final DateTime? initialValue;
  final ValueChanged<DateTime> onNext;

  const BirthDateStep({
    super.key,
    required this.initialValue,
    required this.onNext,
  });

  @override
  State<BirthDateStep> createState() => _BirthDateStepState();
}

class _BirthDateStepState extends State<BirthDateStep> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(now.year - 20),
      firstDate: DateTime(1940),
      lastDate: now,
      locale: const Locale('pt', 'BR'),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _continue() {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione sua data de nascimento.',
          ),
        ),
      );
      return;
    }

    widget.onNext(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Qual é sua data de nascimento?',
      description:
          'Precisamos dela para calcular sua idade e personalizar seus resultados.',
      buttonText: 'Continuar',
      onPressed: _continue,
      child: InkWell(
        onTap: _pickDate,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'Selecionar data'
                      : DateFormat(
                          'dd/MM/yyyy',
                        ).format(_selectedDate!),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
