library radio;

import 'package:polymer/polymer.dart';

@CustomTag('ur-radio')
class UrRadio extends PolymerElement
{
	@published String label = '';
	UrRadio.created() : super.created();
}