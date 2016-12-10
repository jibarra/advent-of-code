var PossibleTriangle = function(){
	this.puzzleInput = 'puzzleInput.txt';
	this.input2 = " 5 10 25";
	this.lineRegex = new RegExp("\\s+");

	this.run = function(){
		this.getInput(this.puzzleInput);
		this.part1(this.input2);
		// this.part1(this.input3.split('\n'));
	};

	this.getInput = function(fileName){
		// client.onreadystatechange = function() {
		// 	functionToRun(client.responseText.split('\n'));
		// }
		var that = this;
		$.get(fileName, function(data){
			that.part1(data.split('\n'));
		});
	}

	this.part1 = function(input){
		var possibleTriangleCount = 0;
		for(var i = 0; i < input.length; i++){
			var triangleSides = input[i].split(this.lineRegex);
			//Remember to parse int. Caused problems earlier doing comparison with the strings
			if(this.isValidTriangle(parseInt(triangleSides[1]), parseInt(triangleSides[2]), parseInt(triangleSides[3])) === true){
				possibleTriangleCount++;
			}
		}
		console.log("Possible Triangles: " + possibleTriangleCount);
	};

	this.isValidTriangle = function(side1, side2, side3){
		if((side1 + side2) > side3
				&& (side2 + side3) > side1
				&& (side1 + side3) > side2){
			return true;
		}
		return false;
	};
};