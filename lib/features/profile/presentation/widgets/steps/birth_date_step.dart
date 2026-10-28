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
  State<BirthDateStep> createState() =>
      _BirthDateStepState();
}



class _BirthDateStepState
    extends State<BirthDateStep> {


  DateTime? _selectedDate;


  final TextEditingController _controller =
      TextEditingController();



  @override
  void initState() {
    super.initState();

    _selectedDate =
        widget.initialValue;


    if (_selectedDate != null) {

      _controller.text =
          DateFormat(
            'dd/MM/yyyy',
          ).format(
            _selectedDate!,
          );
    }
  }



  void _formatDate(
    String value,
  ) {


    var numbers =
        value.replaceAll(
          RegExp(r'[^0-9]'),
          '',
        );


    if (numbers.length > 8) {

      numbers =
          numbers.substring(
            0,
            8,
          );
    }



    String formatted =
        numbers;



    if (numbers.length >= 5) {

      formatted =
          '${numbers.substring(0,2)}/'
          '${numbers.substring(2,4)}/'
          '${numbers.substring(4)}';

    } else if (numbers.length >= 3) {

      formatted =
          '${numbers.substring(0,2)}/'
          '${numbers.substring(2)}';
    }



    _controller.value =
        TextEditingValue(

      text:
          formatted,

      selection:
          TextSelection.collapsed(
        offset:
            formatted.length,
      ),
    );



    _tryParseDate(
      formatted,
    );
  }




  void _tryParseDate(
    String value,
  ) {


    if (value.length != 10) {

      return;
    }



    try {

      final date =
          DateFormat(
            'dd/MM/yyyy',
          ).parseStrict(
            value,
          );


      setState(() {

        _selectedDate =
            date;

      });


    } catch (_) {

      setState(() {

        _selectedDate =
            null;

      });

    }
  }





  Future<void> _pickDate() async {

    final now =
        DateTime.now();



    final date =
        await showDatePicker(

      context:
          context,

      initialDate:
          _selectedDate ??
              DateTime(
                now.year - 20,
              ),

      firstDate:
          DateTime(
            1940,
          ),

      lastDate:
          now,

      locale:
          const Locale(
            'pt',
            'BR',
          ),
    );



    if (date != null) {

      setState(() {

        _selectedDate =
            date;


        _controller.text =
            DateFormat(
              'dd/MM/yyyy',
            ).format(
              date,
            );

      });

    }
  }





  void _continue() {

    if (_selectedDate == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
            'Digite uma data válida.',
          ),

        ),

      );


      return;
    }



    widget.onNext(
      _selectedDate!,
    );
  }





  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }





  @override
  Widget build(
    BuildContext context,
  ) {


    return OnboardingPage(

      title:
          'Qual é sua data de nascimento?',


      description:
          'Precisamos dela para calcular sua idade e personalizar seus resultados.',


      buttonText:
          'Continuar',


      onPressed:
          _continue,


      child:
          TextField(

        controller:
            _controller,


        keyboardType:
            TextInputType.number,


        onChanged:
            _formatDate,


        decoration:
            InputDecoration(

          hintText:
              'DD/MM/AAAA',


          prefixIcon:
              const Icon(
            Icons.calendar_month,
          ),


          suffixIcon:
              IconButton(

            icon:
                const Icon(
              Icons.date_range,
            ),


            onPressed:
                _pickDate,

          ),

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              12,
            ),

          ),

        ),

      ),

    );
  }
}