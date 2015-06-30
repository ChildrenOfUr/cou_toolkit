library slider;

import 'package:polymer/polymer.dart';

@CustomTag('ur-slider')
class UrSlider extends PolymerElement
{
	@published num value = 50, min = 0, max = 100;
	UrSlider.created() : super.created();
}