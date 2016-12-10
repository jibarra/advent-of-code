var PossibleTriangle = function(){
	this.puzzleInput = 'puzzleInput.txt';
	this.input2 = " 5 10 25";
	this.lineRegex = new RegExp("\\s+");

	this.run = function(){
		var that = this;
		$.get(that.puzzleInput, function(data){
			that.part1(data.split('\n'));
		});

		$.get(that.puzzleInput, function(data){
			that.part2(data.split('\n'));
		});
	};

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

	this.part2 = function(input){
		var possibleTriangleCount = 0;
		for(var i = 0; i < input.length; i+=3){
			var triangleSides1 = input[i].split(this.lineRegex);
			var triangleSides2 = input[i+1].split(this.lineRegex);
			var triangleSides3 = input[i+2].split(this.lineRegex);
			//Remember to parse int. Caused problems earlier doing comparison with the strings
			if(this.isValidTriangle(parseInt(triangleSides1[1]), parseInt(triangleSides2[1]), parseInt(triangleSides3[1])) === true){
				possibleTriangleCount++;
			}
			if(this.isValidTriangle(parseInt(triangleSides1[2]), parseInt(triangleSides2[2]), parseInt(triangleSides3[2])) === true){
				possibleTriangleCount++;
			}
			if(this.isValidTriangle(parseInt(triangleSides1[3]), parseInt(triangleSides2[3]), parseInt(triangleSides3[3])) === true){
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