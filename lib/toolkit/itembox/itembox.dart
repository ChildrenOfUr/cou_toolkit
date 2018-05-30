library itembox;

import 'package:angular/angular.dart';
import 'package:dnd/dnd.dart';

@Component(
	selector: 'ur-itembox',
	templateUrl: 'itembox.html',
	styleUrls: const ['itembox.styles']
)
class UrItemBox extends Component {
	String item = '';
	int quantity = 0;

	Draggable _dragItem;
	Dropzone _dropBox;

	UrItemBox(ElementRef host) {
		_dragItem = new Draggable(host.nativeElement, avatarHandler: new AvatarHandler.clone());
		_dropBox = new Dropzone(host.nativeElement);

		// Hide the 'panel' element of our dragged object
		_dragItem.onDrag.listen((_) {
			_dragItem.avatarHandler.avatar
				.querySelector('.panel')
				.style
				..backgroundColor = 'transparent'
				..border = 'none';
		});

		_dropBox.onDrop.listen((d) {
			// Don't drag nothingness
			if (d.draggableElement.attributes['item'] == '') {
				return;
			}

			// Add to similar item stacks, but don't add to different stacks
			if (d.dropzoneElement.attributes['item'] != '') {
				if (d.dropzoneElement.attributes['item'] == d.draggableElement.attributes['item']) {
					int total = int.parse(d.draggableElement.attributes['quantity']) + int.parse(d.dropzoneElement.attributes['quantity']);
					d.draggableElement.attributes['quantity'] = total.toString();
				} else {
					//since this swaps all the attributes of each element
					//it effectively swaps the elements
					Map<String, String> temp = {};
					d.draggableElement.attributes.forEach((key, value) => temp[key] = value);
					d.draggableElement.attributes = d.dropzoneElement.attributes;
					d.dropzoneElement.attributes = temp;
					return;
				}
			}

			d.dropzoneElement.attributes['item'] = d.draggableElement.attributes['item'];
			d.dropzoneElement.attributes['quantity'] = d.draggableElement.attributes['quantity'];
			d.draggableElement.attributes['item'] = '';
			d.draggableElement.attributes['quantity'] = "0";
		});
	}
}