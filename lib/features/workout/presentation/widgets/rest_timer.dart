import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class RestTimer extends StatefulWidget {
  const RestTimer({
    super.key,
    required this.seconds,
    required this.onFinished,
  });

  final int seconds;
  final VoidCallback onFinished;

  @override
  State<RestTimer> createState() =>
      _RestTimerState();
}


class _RestTimerState extends State<RestTimer>
    with SingleTickerProviderStateMixin {

  Timer? _timer;

  late int _remaining;

  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();

    _remaining =
        widget.seconds;

    _animationController =
        AnimationController(
      vsync: this,
      duration: Duration(
        seconds: widget.seconds,
      ),
    );

    _animationController.forward();

    _start();
  }


  void _start() {
    _timer = Timer.periodic(
      const Duration(
        seconds: 1,
      ),
      (_) {

        if (_remaining <= 1) {
          _timer?.cancel();

          setState(() {
            _remaining = 0;
          });

          widget.onFinished();

          return;
        }


        setState(() {
          _remaining--;
        });
      },
    );
  }


  void _skip() {
    _timer?.cancel();

    _animationController.stop();

    widget.onFinished();
  }


  String get _time {

    final minutes =
        (_remaining ~/ 60)
            .toString()
            .padLeft(2, '0');


    final seconds =
        (_remaining % 60)
            .toString()
            .padLeft(2, '0');


    return '$minutes:$seconds';
  }


  double get _progress {

    if (widget.seconds == 0) {
      return 0;
    }


    return _remaining /
        widget.seconds;
  }


  @override
  void dispose() {

    _timer?.cancel();

    _animationController.dispose();

    super.dispose();
  }


  @override
  Widget build(
    BuildContext context,
  ) {

    return Container(
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(

        color:
            AppColors.ink,

        borderRadius:
            BorderRadius.circular(28),

        border: Border.all(
          color:
              AppColors.volt.withValues(
            alpha: .25,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: .25,
            ),
            blurRadius: 20,
            offset:
                const Offset(0, 10),
          ),
        ],
      ),


      child: Column(
        mainAxisSize:
            MainAxisSize.min,

        children: [

          Container(
            width: 72,
            height: 72,

            decoration: BoxDecoration(
              color:
                  AppColors.volt.withValues(
                alpha: .12,
              ),

              shape:
                  BoxShape.circle,
            ),

            child: const Icon(
              Icons.timer_outlined,
              color:
                  AppColors.volt,
              size:
                  38,
            ),
          ),


          const SizedBox(
            height: 16,
          ),


          Text(
            'DESCANSO',
            style:
                AppTypography.bodySecondary.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),


          const SizedBox(
            height: 14,
          ),


          SizedBox(
            width: 150,
            height: 150,

            child: Stack(
              alignment:
                  Alignment.center,

              children: [

                SizedBox(
                  width: 150,
                  height: 150,

                  child:
                      CircularProgressIndicator(
                    value:
                        _progress,

                    strokeWidth:
                        10,

                    backgroundColor:
                        Colors.white12,

                    valueColor:
                        const AlwaysStoppedAnimation(
                      AppColors.volt,
                    ),
                  ),
                ),


                Text(
                  _time,

                  style:
                      AppTypography.headlineMedium.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),


          const SizedBox(
            height: 20,
          ),


          SizedBox(
            width:
                double.infinity,

            child:
                FilledButton(
              onPressed:
                  _skip,

              child:
                  const Padding(
                padding:
                    EdgeInsets.symmetric(
                  vertical: 14,
                ),

                child:
                    Text(
                  'PULAR DESCANSO',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}