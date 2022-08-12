import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/model/vol_model.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/utils/dependency_injection.dart' as di;
import 'package:flutter_template/viewModel/add_admin_view_model.dart';
import 'package:flutter_template/viewModel/admins_screen_view_model.dart';
import 'package:flutter_template/viewModel/brise_view_model.dart';
import 'package:flutter_template/viewModel/clients_screen_view_model.dart';
import 'package:flutter_template/viewModel/home_view_model.dart';
import 'package:flutter_template/viewModel/incendie_view_model.dart';
import 'package:flutter_template/viewModel/login_view_model.dart';
import 'package:flutter_template/viewModel/stat_view_model.dart';
import 'package:flutter_template/viewModel/vol_view_model.dart';
import 'package:flutter_template/views/pages/Administrateurs/AdminScreenDetails.dart';
import 'package:flutter_template/views/pages/Administrateurs/add_admin_screen.dart';
import 'package:flutter_template/views/pages/Administrateurs/update_admin_screen.dart';
import 'package:flutter_template/views/pages/BriseGlace/brise_glace_screen.dart';
import 'package:flutter_template/views/pages/BriseGlace/detail_brise_screen.dart';
import 'package:flutter_template/views/pages/Clients/add_client.dart';
import 'package:flutter_template/views/pages/Clients/clients_screen.dart';
import 'package:flutter_template/views/pages/Clients/detail_client.dart';
import 'package:flutter_template/views/pages/Constats/details_constat_screen.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_detail_screen.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_screen.dart';
import 'package:flutter_template/views/pages/Vols/vol_details_screen.dart';
import 'package:flutter_template/views/pages/Vols/vols_screen.dart';
import 'package:flutter_template/views/pages/archive/BriseTraite/brise_traite.dart';
import 'package:flutter_template/views/pages/archive/ConstatRejeter/constat_rejete_screen.dart';
import 'package:flutter_template/views/pages/archive/ConstatTraite/constat_traite_screen.dart';
import 'package:flutter_template/views/pages/archive/Incendies/incendies_traite.dart';
import 'package:flutter_template/views/pages/archive/VolTraite/vols_traite.dart';
import 'package:flutter_template/views/pages/dashboard/constat_non_traite_screen.dart';
import 'package:flutter_template/views/pages/login/login_screen.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';
import 'package:flutter_template/views/pages/statestiques/stat_screen.dart';
import 'package:flutter_template/views/views.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controllers/MenuController.dart';

void main() async {
  setPathUrlStrategy();
  await di.init();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: DefaultSizeInit(builder: () => const MyApp()),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routerDelegate = BeamerDelegate(
    initialPath: SplashScreen.path,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        SplashScreen.path: (context, state, data) => const SplashScreen(),
        LoginPage.path: (context, state, data) => const LoginPage(),
        MainScreen.path: (context, state, data) => const MainScreen(),
        ConstatNonTraiteScreen.path: (context, state, data) =>
            const ConstatNonTraiteScreen(),
        ConstatRejete.path: (context, state, data) => const ConstatRejete(),
        ConstatTraite.path: (context, state, data) => const ConstatTraite(),
        VolNonTraiteScreen.path: (context, state, data) =>
            const VolNonTraiteScreen(),
        IncendiesNonTraiteScreen.path: (context, state, data) =>
            const IncendiesNonTraiteScreen(),
        BriseGlaceNonTraiteScreen.path: (context, state, data) =>
            const BriseGlaceNonTraiteScreen(),
        VolTraite.path: (context, state, data) => const VolTraite(),
        BriseTraite.path: (context, state, data) => const BriseTraite(),
        IncendiesTraite.path: (context, state, data) => const IncendiesTraite(),
        StatScreen.path: (context, state, data) => const StatScreen(),
        AdminsDashboard.path: (context, state, data) => const AdminsDashboard(),
        AddAdmin.path: (context, state, data) => const AddAdmin(),
        AddClient.path: (context, state, data) => const AddClient(),
        ClientDashboard.path: (context, state, data) => const ClientDashboard(),
        DetailsConstat.path + "/:id": (context, state, data) {
          final constatId = state.pathParameters['id']!;
          final info = (data as ConstatModel);
          return BeamPage(
            key: ValueKey('constat-$constatId'),
            title: 'Detail Constat',
            popToNamed: MainScreen.title,
            type: BeamPageType.scaleTransition,
            child: DetailsConstat(ConstatId: constatId, constat: info),
          );
        },
        DetailsBriseGlace.path + "/:id": (context, state, data) {
          final Id = state.pathParameters['id']!;
          final info = (data as BriseGlaceModel);
          return BeamPage(
            key: ValueKey('brise-$Id'),
            title: 'Detail Brise Glasse',
            popToNamed: BriseGlaceNonTraiteScreen.title,
            type: BeamPageType.scaleTransition,
            child: DetailsBriseGlace(
              id: Id,
              brise: info,
            ),
          );
        },
        DetailVol.path + "/:id": (context, state, data) {
          final Id = state.pathParameters['id']!;
          final info = (data as VolModel);
          return BeamPage(
            key: ValueKey('brise-$Id'),
            title: 'Detail Brise Glasse',
            popToNamed: BriseGlaceNonTraiteScreen.title,
            type: BeamPageType.scaleTransition,
            child: DetailVol(
              id: Id,
              vol: info,
            ),
          );
        },
        DetailIncendie.path + "/:id": (context, state, data) {
          final Id = state.pathParameters['id']!;
          final info = (data as IncendiesModel);
          return BeamPage(
            key: ValueKey('brise-$Id'),
            title: 'Detail Brise Glasse',
            popToNamed: BriseGlaceNonTraiteScreen.title,
            type: BeamPageType.scaleTransition,
            child: DetailIncendie(
              id: Id,
              incendie: info,
            ),
          );
        },
        UpdateAdmin.path + "/:id": (context, state, data) {
          final Id = state.pathParameters['id']!;
          final info = (data as AdminModel);
          return BeamPage(
            key: ValueKey('admin-$Id'),
            title: 'Modifier Administrateur',
            popToNamed: AdminsDashboard.title,
            type: BeamPageType.scaleTransition,
            child: UpdateAdmin(
              AdminId: Id,
              admin: info,
            ),
          );
        },
        DetailClient.path + "/:id": (context, state, data) {
          final clientId = state.pathParameters['id']!;
          final info = (data as ClientModel);
          return BeamPage(
            key: ValueKey('client-$clientId'),
            title: 'Detail Client',
            popToNamed: '/home',
            type: BeamPageType.scaleTransition,
            child: DetailClient(clientId: clientId, client: info),
          );
        }
      },
    ),
    notFoundRedirectNamed: SplashScreen.path,
  );
  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeTestViewModel>(
          create: (_) => HomeTestViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.system,
        initialRoute: MainScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          MyHomePage.id: (context) => const MyHomePage(),
          MainScreen.id: (context) => const MainScreen(),
        },
      ),
    );*/
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        */ /*child: GetMaterialApp(
          initialRoute: LoginPage.id,
          routes: {
            MainScreen.id: (context) => const MainScreen(),
            MyHomePage.id: (context) => const MyHomePage(),
            LoginPage.id: (context) => const LoginPage(),
          },
        ),*/ /*
        child: const LoginPage(),
      ),
    );*/
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddAdminViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => VolViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => BriseViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => IncendiesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => StatViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddAdminViewModel(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
        backButtonDispatcher:
            BeamerBackButtonDispatcher(delegate: routerDelegate),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        /*theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),*/
        theme: ThemeData.light(),
      ),
    );
  }
}
