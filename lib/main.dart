import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simpli/layout.dart';
import 'package:simpli/models/invoice_model.dart';
import 'package:simpli/screens/invoice/invoice_screen.dart';
import 'package:simpli/screens/login_screen.dart';
import 'package:simpli/services/focus_node_provider.dart';
import 'package:simpli/services/invoice_provider.dart';
import 'package:simpli/services/login_state.dart';
import 'package:simpli/services/modal_position_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();
    Hive.registerAdapter(InvoiceAdapter());
    Hive.registerAdapter(InvoiceItemAdapter());
    
    final invoiceBox = await Hive.openBox<Invoice>('invoices');
    final metadataBox = await Hive.openBox<int>('metadata');

    if (!metadataBox.containsKey('lastInvoiceNumber')) {
      await metadataBox.put('lastInvoiceNumber', 0);
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginState()),
          ChangeNotifierProvider(
            create: (_) => InvoiceProvider(invoiceBox, metadataBox),
          ),
          ChangeNotifierProvider(create: (_) => FocusNodeProvider()),
          ChangeNotifierProvider(create: (context) => PositionProvider()),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print('Error initializing app: $e');
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Failed to initialize app. Please restart.'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // Close Hive boxes when app is disposed
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HR Prototype',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.teal,
        hintColor: const Color(0xFF114F5A),
        cardTheme: const CardTheme(
          color: Colors.transparent,
          elevation: 4,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case '/':
        page = const LoginScreen();
        break;
      case '/home':
        page = const Layout(child: InvoiceScreen());
        break;
      default:
        page = const LoginScreen();
    }

    return _createRoute(page);
  }

  Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}