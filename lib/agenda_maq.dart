import 'package:agendamaq/app/components/splash_screen.dart';
import 'package:agendamaq/app/home/home.dart';
import 'package:agendamaq/app/initial/initial.dart';
import 'package:agendamaq/app/locality/create_locality.dart';
import 'package:agendamaq/app/machine/create_machine.dart';
import 'package:agendamaq/app/schedule/create_schedule.dart';
import 'package:agendamaq/app/service/create_service.dart';
import 'package:agendamaq/app/user/create_user.dart';
import 'package:agendamaq/app/user/login_page.dart';
import 'package:agendamaq/controller/locality_controller.dart';
import 'package:agendamaq/controller/machine_controller.dart';
import 'package:agendamaq/controller/schedule_controller.dart';
import 'package:agendamaq/controller/services_controller.dart';
import 'package:agendamaq/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaMacApp extends StatelessWidget {
  const AgendaMacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalityController()),
        ChangeNotifierProvider(create: (_) => MachineController()),
        ChangeNotifierProvider(create: (_) => ScheduleController()),
        ChangeNotifierProvider(create: (_) => ServicesController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agenda Mac',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const InitialPage(),
        routes: {
          AppRouters.INITIAL: (context) => const InitialPage(),
          AppRouters.CREATEUSER: (context) => const CreateUser(),
          AppRouters.LOGIN_PAGE: (context) => const LoginPage(),
          AppRouters.HOME: (context) => const Home(),
          AppRouters.SPLASH_SCREEN: (context) => const SplashScreen(),
          AppRouters.CREATE_LOCALITY: (context) => const CreateLocality(),
          AppRouters.CREATE_MACHINE: (context) => const CreateMachine(),
          AppRouters.CREATE_SCHEDULE: (context) => const CreateSchedule(),
          AppRouters.CREATE_SERVICE: (context) => const CreateService(),
        },
      ),
    );
  }
}
