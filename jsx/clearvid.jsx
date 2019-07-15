{
	function parse(txt, layer, comp) {
		var mask = layer.property("Masks").addProperty("Mask");
		var path = mask.property("Mask Path");
		var lines = txt.split("\n");
		while (lines.length) {
			var line = lines.shift();
			if (line.indexOf("frame: ") !== -1) {
				var frame = parseInt(line.split(": ").pop());
				lines.shift();
				var coords = lines.shift().split(",");
				var verts = [];
				while (coords.length) {
					var x = parseInt(coords.shift());
					var y = parseInt(coords.shift());
					if (x !== null && y !== null) {
						verts.push([x, y]);
					}
				}
				var maskShape = new Shape();
				maskShape.vertices = verts;
				maskShape.closed = true;
				path.setValueAtTime(frame * comp.frameDuration, maskShape);
			}
		}
	}
	
	function importMask() {
		var activeItem = app.project.activeItem;
		if ((activeItem == null) || !(activeItem instanceof CompItem)) {
			alert("Please select a video in a composition first.");
		} else {
			var selectedLayers = activeItem.selectedLayers;
			if (activeItem.selectedLayers.length === 0) {
				alert("Please select a video in the composition first.");
			} else {
				var layer = selectedLayers[0];
				if (layer instanceof AVLayer) {
					var textFile = File.openDialog("Import Clearvid Mask");
					if (!textFile) return;
					if (textFile.open("r")) {
						var extension = textFile.name.split(".").pop();
						if (extension === "txt") {
							var content = textFile.read();
							textFile.close();
							parse(content, layer, activeItem);
						} else {
							alert("Not a Clearvid Mask!\nPlease open .txt files, not ." + extension + " files!");
							importMask();
						}
					} else {
						alert("Couldn't read the file!");
					}
				} else {
					alert("Please select a video layer.");
				}
			}
		}
	}

	importMask();
}
