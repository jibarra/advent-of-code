var Day2 = function(){
	this.input1 = "RDLRUUULRRDLRLLRLDDUDLULULDDULUDRRUURLRLLUULDURRULLRULDRRDLLULLRLLDRLDDRRRRLLRLURRRDRDULRDUULDDDULURUDDRRRUULUDRLLUUURLUDRUUUDRDUULLRLLUDDRURRDDDRDLUUURLRLLUDRURDUDUULDDLLRDURULLLURLDURLUUULDULDDULULLLRRUDLRUURDRDLLURLUDULDUUUURRLDLUDRULUDLDLLDRLDDDRRLLDUDLLRRDDDRLUDURLLLDRUDDLDDRRLUDRRDUDLRRLULDULURULDULUULDRLLDRUUDDRLLUDRULLRRRLRDLRLUDLRULDRDLRDRLRULUDUURRUUULLDDDDUDDLDDDDRRULRDLRDDULLDLDLLDLLDLLDRRDDDRDDLRRDDDRLLLLURRDLRRLDRURDDURDULDDRUURUDUDDDRDRDDRLRRLRULLDRLDLURLRLRUDURRRDLLLUDRLRDLLDDDLLUDRLDRRUUDUUDULDULLRDLUDUURLDDRUDR\nURULDDLDDUDLLURLUUUUUULUDRRRDDUDURDRUURLLDRURLUULUDRDRLLDRLDULRULUURUURRLRRDRUUUDLLLLRUDDLRDLLDUDLLRRURURRRUDLRLRLLRULRLRLRDLRLLRRUDDRLRUDULDURDLDLLLRDRURURRULLLDLLRRDRLLDUUDLRUUDDURLLLDUUDLRDDURRDRRULLDRLRDULRRLLRLLLLUDDDRDRULRRULLRRUUDULRRRUDLLUUURDUDLLLURRDDUDLDLRLURDDRRRULRRUDRDRDULURULRUDULRRRLRUDLDDDDRUULURDRRDUDLULLRUDDRRRLUDLRURUURDLDURRDUUULUURRDULLURLRUUUUULULLDRURULDURDDRRUDLRLRRLLLLDDUURRULLURURRLLDRRDDUUDLLUURRDRLLLLRLUDUUUDLRLRRLDURDRURLRLRULURLDULLLRRUUUDLLRRDUUULULDLLDLRRRDUDDLRULLULLULLULRU\nDURUUDULRRLULLLDDUDDLRRDURURRRDDRRURDRURDRLULDUDUDUULULDDUURDDULRDUDUDRRURDRDDRLDRDRLDULDDULRULLDULURLUUDUDULRDDRRLURLLRRDLLDLDURULUDUDULDRLLRRRUDRRDDDRRDRUUURLDLURDLRLLDUULLRULLDDDDRULRRLRDLDLRLUURUUULRDUURURLRUDRDDDRRLLRLLDLRULUULULRUDLUDULDLRDDDDDRURDRLRDULRRULRDURDDRRUDRUDLUDLDLRUDLDDRUUULULUULUUUDUULDRRLDUDRRDDLRUULURLRLULRURDDLLULLURLUDLULRLRRDDDDDRLURURURDRURRLLLLURLDDURLLURDULURUUDLURUURDLUUULLLLLRRDUDLLDLUUDURRRURRUUUDRULDDLURUDDRRRDRDULURURLLDULLRDDDRRLLRRRDRLUDURRDLLLLDDDDLUUURDDDDDDLURRURLLLUURRUDLRLRRRURULDRRLULD\nLLUUURRDUUDRRLDLRUDUDRLRDLLRDLLDRUULLURLRRLLUDRLDDDLLLRRRUDULDLLLDRLURDRLRRLURUDULLRULLLURRRRRDDDLULURUDLDUDULRRLUDDURRLULRRRDDUULRURRUULUURDRLLLDDRDDLRRULRDRDRLRURULDULRRDRLDRLLDRDURUUULDLLLRDRRRLRDLLUDRDRLURUURDLRDURRLUDRUDLURDRURLRDLULDURDDURUUDRLULLRLRLDDUDLLUUUURLRLRDRLRRRURLRULDULLLLDLRRRULLUUDLDURUUUDLULULRUDDLLDLDLRLDDUDURDRLLRRLRRDDUDRRRURDLRLUUURDULDLURULUDULRRLDUDLDDDUUDRDUULLDDRLRLLRLLLLURDDRURLDDULLULURLRDUDRDDURLLLUDLLLLLUDRDRDLURRDLUDDLDLLDDLUDRRDDLULRUURDRULDDDLLRLDRULURLRURRDDDRLUUDUDRLRRUDDLRDLDULULDDUDURRRURULRDDDUUDULLULDDRDUDRRDRDRDLRRDURURRRRURULLLRRLR\nURLULLLDRDDULRRLRLUULDRUUULDRRLLDDDLDUULLDRLULRRDRRDDDRRDLRRLLDDRDULLRRLLUDUDDLDRDRLRDLRDRDDUUDRLLRLULLULRDRDDLDDDRLURRLRRDLUDLDDDLRDLDLLULDDRRDRRRULRUUDUULDLRRURRLLDRDRRDDDURUDRURLUDDDDDDLLRLURULURUURDDUDRLDRDRLUUUULURRRRDRDULRDDDDRDLLULRURLLRDULLUUDULULLLLRDRLLRRRLLRUDUUUULDDRULUDDDRRRULUDURRLLDURRDULUDRUDDRUURURURLRDULURDDDLURRDLDDLRUDUUDULLURURDLDURRDRDDDLRRDLLULUDDDRDLDRDRRDRURRDUDRUURLRDDUUDLURRLDRRDLUDRDLURUDLLRRDUURDUDLUDRRL";
	this.input2 = "ULL\nRRDDD\nLURDL\nUUUUD";
	this.run = function(){
		var inputs = this.input1.split('\n');
		this.part1(inputs);
		// this.part2(inputs);
	};

	this.part1 = function(inputs){
		//Starting direction
		var currentCardinalDirection = 'north';
		var buttonPresses = [];

		var currentButton = 5;

		for(var i = 0; i < inputs.length; i++){
			for(var j = 0; j < inputs[i].length; j++){
				currentButton = this.pressButton(currentButton, inputs[i][j]);
			}
			buttonPresses.push(currentButton);
		}

		var bathroomCode = '';

		for(var i = 0; i < buttonPresses.length; i++){
			console.log(buttonPresses[i]);
			bathroomCode = bathroomCode + buttonPresses[i];
		}

		console.log("Part 1: Buton presses: " + bathroomCode);
	};

	this.pressButton = function(currentButton, direction){
		if(currentButton === 1){
			return this.press1Button(direction);
		}
		else if(currentButton === 2){
			return this.press2Button(direction);
		}
		else if(currentButton === 3){
			return this.press3Button(direction);
		}
		else if(currentButton === 4){
			return this.press4Button(direction);
		}
		else if(currentButton === 5){
			return this.press5Button(direction);
		}
		else if(currentButton === 6){
			return this.press6Button(direction);
		}
		else if(currentButton === 7){
			return this.press7Button(direction);
		}
		else if(currentButton === 8){
			return this.press8Button(direction);
		}
		else if(currentButton === 9){
			return this.press9Button(direction);
		}
	};

	this.press1Button = function(direction){
		if(direction === 'U'){
			return 1;
		}
		else if(direction === 'R'){
			return 2;
		}
		else if(direction === 'D'){
			return 4;
		}
		else if(direction === 'L'){
			return 1;
		}
	};

	this.press2Button = function(direction){
		if(direction === 'U'){
			return 2;
		}
		else if(direction === 'R'){
			return 3;
		}
		else if(direction === 'D'){
			return 5;
		}
		else if(direction === 'L'){
			return 1;
		}
	};

	this.press3Button = function(direction){
		if(direction === 'U'){
			return 3;
		}
		else if(direction === 'R'){
			return 3;
		}
		else if(direction === 'D'){
			return 6;
		}
		else if(direction === 'L'){
			return 2;
		}
	};

	this.press4Button = function(direction){
		if(direction === 'U'){
			return 1;
		}
		else if(direction === 'R'){
			return 5;
		}
		else if(direction === 'D'){
			return 7;
		}
		else if(direction === 'L'){
			return 4;
		}
	};

	this.press5Button = function(direction){
		if(direction === 'U'){
			return 2;
		}
		else if(direction === 'R'){
			return 6;
		}
		else if(direction === 'D'){
			return 8;
		}
		else if(direction === 'L'){
			return 4;
		}
	};

	this.press6Button = function(direction){
		if(direction === 'U'){
			return 3;
		}
		else if(direction === 'R'){
			return 6;
		}
		else if(direction === 'D'){
			return 9;
		}
		else if(direction === 'L'){
			return 5;
		}
	};

	this.press7Button = function(direction){
		if(direction === 'U'){
			return 4;
		}
		else if(direction === 'R'){
			return 8;
		}
		else if(direction === 'D'){
			return 7;
		}
		else if(direction === 'L'){
			return 7;
		}
	};

	this.press8Button = function(direction){
		if(direction === 'U'){
			return 5;
		}
		else if(direction === 'R'){
			return 9;
		}
		else if(direction === 'D'){
			return 8;
		}
		else if(direction === 'L'){
			return 7;
		}
	};

	this.press9Button = function(direction){
		if(direction === 'U'){
			return 6;
		}
		else if(direction === 'R'){
			return 9;
		}
		else if(direction === 'D'){
			return 9;
		}
		else if(direction === 'L'){
			return 8;
		}
	};
};