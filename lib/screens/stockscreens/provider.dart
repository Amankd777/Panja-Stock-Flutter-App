
import 'package:panja/screens/stockscreens/theme_provider.dart';
import 'package:panja/screens/stockscreens/trades_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'company_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => CompanyProvider()),
  ChangeNotifierProvider(create: (_) => TradeProvider()),
  ChangeNotifierProvider(create: (_) => AppProvider()),
];
