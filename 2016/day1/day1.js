var Day1 = function(){
	this.input1 = "R3, L5, R2, L1, L2, R5, L2, R2, L2, L2, L1, R2, L2, R4, R4, R1, L2, L3, R3, L1, R2, L2, L4, R4, R5, L3, R3, L3, L3, R4, R5, L3, R3, L5, L1, L2, R2, L1, R3, R1, L1, R187, L1, R2, R47, L5, L1, L2, R4, R3, L3, R3, R4, R1, R3, L1, L4, L1, R2, L1, R4, R5, L1, R77, L5, L4, R3, L2, R4, R5, R5, L2, L2, R2, R5, L2, R194, R5, L2, R4, L5, L4, L2, R5, L3, L2, L5, R5, R2, L3, R3, R1, L4, R2, L1, R5, L1, R5, L1, L1, R3, L1, R5, R2, R5, R5, L4, L5, L5, L5, R3, L2, L5, L4, R3, R1, R1, R4, L2, L4, R5, R5, R4, L2, L2, R5, R5, L5, L2, R4, R4, L4, R1, L3, R1, L1, L1, L1, L4, R5, R4, L4, L4, R5, R3, L2, L2, R3, R1, R4, L3, R1, L4, R3, L3, L2, R2, R2, R2, L1, L4, R3, R2, R2, L3, R2, L3, L2, R4, L2, R3, L4, R5, R4, R1, R5, R3";
	this.input2 = "R8, R4, R4, R8";
	this.run = function(){
		var inputs = this.input1.split(', ');
		this.part1(inputs);
		this.part2(inputs);
	};

	this.part1 = function(inputs){
		//Starting direction
		var currentCardinalDirection = 'north';

		//North will be positive, south negative
		var northSouthSpaces = 0;
		//East will be positive, west negative
		var eastWestSpaces = 0;

		for(var i = 0; i < inputs.length; i++){
			var moveDirection = inputs[i][0];
			var moveSpaces = parseInt(inputs[i].slice(1));

			if(currentCardinalDirection === 'north'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'east';
					eastWestSpaces += moveSpaces;
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'west';
					eastWestSpaces -= moveSpaces;
				}
			}
			else if(currentCardinalDirection === 'south'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'west';
					eastWestSpaces -= moveSpaces;
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'east';
					eastWestSpaces += moveSpaces;
				}
			}
			else if(currentCardinalDirection === 'east'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'south';
					northSouthSpaces -= moveSpaces;
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'north';
					northSouthSpaces += moveSpaces;
				}
			}
			else if(currentCardinalDirection === 'west'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'north';
					northSouthSpaces += moveSpaces;
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'south';
					northSouthSpaces -= moveSpaces;
				}
			}
		}

		var totalSpaces = Math.abs(northSouthSpaces) + Math.abs(eastWestSpaces);
		console.log("Part 1: Total blocks away: " + totalSpaces);
	};

	this.part2 = function(inputs){
		//Starting direction
		var currentCardinalDirection = 'north';

		var pointsVisited = [];
		var firstTwicePoint = null;
		pointsVisited.push(new Point(0, 0));
		for(var i = 0; i < inputs.length; i++){
			var moveDirection = inputs[i][0];
			var moveSpaces = parseInt(inputs[i].slice(1));

			if(currentCardinalDirection === 'north'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'east';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'west';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
			}
			else if(currentCardinalDirection === 'south'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'west';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'east';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
			}
			else if(currentCardinalDirection === 'east'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'south';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'north';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
			}
			else if(currentCardinalDirection === 'west'){
				if(moveDirection === 'R'){
					currentCardinalDirection = 'north';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
				else if(moveDirection === 'L'){
					currentCardinalDirection = 'south';
					this.move(pointsVisited, moveSpaces, currentCardinalDirection);
				}
			}
			firstTwicePoint = this.checkVisitedTwice(pointsVisited);
			if(firstTwicePoint !== undefined && firstTwicePoint !== null){
				break;
			}
		}

		var totalSpaces = Math.abs(firstTwicePoint.x) + Math.abs(firstTwicePoint.y);
		console.log("Part 2: Total blocks away: " + totalSpaces);
	};

	this.move = function(pointsVisited, moveSpaces, direction){
		for(var i = 0; i < moveSpaces; i++){
			if(direction === 'north'){
				pointsVisited.push(new Point(pointsVisited[pointsVisited.length-1].x, pointsVisited[pointsVisited.length-1].y + 1));
			}
			else if(direction === 'south'){
				pointsVisited.push(new Point(pointsVisited[pointsVisited.length-1].x, pointsVisited[pointsVisited.length-1].y - 1));
			}
			else if(direction === 'east'){
				pointsVisited.push(new Point(pointsVisited[pointsVisited.length-1].x + 1, pointsVisited[pointsVisited.length-1].y));
			}
			else if(direction === 'west'){
				pointsVisited.push(new Point(pointsVisited[pointsVisited.length-1].x - 1, pointsVisited[pointsVisited.length-1].y));
			}
		}
	};

	this.checkVisitedTwice = function(pointsVisited){
		for(var i = 0; i < pointsVisited.length; i++){
			for(var j = (i + 1); j < pointsVisited.length; j++){
				if(pointsVisited[i].equals(pointsVisited[j]) === true){
					return pointsVisited[i];
				}
			}
		}
		return null;
	};
};

var Point = function(x, y){
	this.x = x;
	this.y = y;

	this.equals = function(otherPoint){
		if(otherPoint === undefined){
			return false;
		}
		// if(typeof otherPoint !== Point){
		// 	return false;
		// }
		if(otherPoint === null){
			return false;
		}
		if(this.x === otherPoint.x && this.y === otherPoint.y){
			return true;
		}
		else{
			return false;
		}
	};
};