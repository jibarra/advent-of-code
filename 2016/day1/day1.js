var Day1 = function(){
	this.input1 = "R3, L5, R2, L1, L2, R5, L2, R2, L2, L2, L1, R2, L2, R4, R4, R1, L2, L3, R3, L1, R2, L2, L4, R4, R5, L3, R3, L3, L3, R4, R5, L3, R3, L5, L1, L2, R2, L1, R3, R1, L1, R187, L1, R2, R47, L5, L1, L2, R4, R3, L3, R3, R4, R1, R3, L1, L4, L1, R2, L1, R4, R5, L1, R77, L5, L4, R3, L2, R4, R5, R5, L2, L2, R2, R5, L2, R194, R5, L2, R4, L5, L4, L2, R5, L3, L2, L5, R5, R2, L3, R3, R1, L4, R2, L1, R5, L1, R5, L1, L1, R3, L1, R5, R2, R5, R5, L4, L5, L5, L5, R3, L2, L5, L4, R3, R1, R1, R4, L2, L4, R5, R5, R4, L2, L2, R5, R5, L5, L2, R4, R4, L4, R1, L3, R1, L1, L1, L1, L4, R5, R4, L4, L4, R5, R3, L2, L2, R3, R1, R4, L3, R1, L4, R3, L3, L2, R2, R2, R2, L1, L4, R3, R2, R2, L3, R2, L3, L2, R4, L2, R3, L4, R5, R4, R1, R5, R3";
	this.run = function(){
		var inputs = this.input1.split(', ');

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
		console.log("Total blocks away: " + totalSpaces);
	}
};