var SecurityObscurity = function(){
	this.puzzleInput = 'puzzleInput.txt';
	this.example1 = "aaaaa-bbb-z-y-x-123[abxyz]";
	this.example2 = "a-b-c-d-e-f-g-h-987[abcde]";
	this.example3 = "not-a-real-room-404[oarel]";
	this.example4 = "totally-real-room-200[decoy]";
	this.numberRegex = new RegExp("[0-9]+");

	this.run = function(){
		var that = this;
        // this.isRealRoom(this.example1);
        // this.isRealRoom(this.example2);
        // this.isRealRoom(this.example3);
        // this.isRealRoom(this.example4);
		$.get(that.puzzleInput, function(data){
			that.countValidSectorIds(data.split('\n'));
		});
        //
		// $.get(that.puzzleInput, function(data){
		// 	that.part2(data.split('\n'));
		// });
	};

	this.countValidSectorIds = function(roomInput){
		var sectorIdSum = 0;
		for(var i = 0; i < roomInput.length; i++){
			if(this.isRealRoom(roomInput[i])){
                var sectorId = parseInt(roomInput[i].match(this.numberRegex)[0]);
				sectorIdSum += sectorId;
			}
        }

        console.log("Valid sector ID sums: " + sectorIdSum);
	};

	this.isRealRoom = function(line){
		var letterGroups = line.split(this.numberRegex);
		var roomName = letterGroups[0].replace(/-/g, '');
		var checksumString = letterGroups[1].replace('[', '').replace(']', '');
		var letterCounts = [];

		while(roomName !== ''){
			var letterCount = new LetterCount(roomName[0], 1);
			for(var i = 1; i < roomName.length; i++){
				if(roomName[i] === letterCount.letter){
                    letterCount.count++;
				}
			}
			var currentLetterRegExp = new RegExp('' + letterCount.letter, 'g');
			roomName = roomName.replace(currentLetterRegExp, '');
			letterCounts.push(letterCount);
		}

		letterCounts.sort(this.compare);

		var actualChecksum = "";

		for(var i = 0; i < 5; i++){
			actualChecksum += letterCounts[i].letter;
		}

		if(actualChecksum === checksumString){
			return true;
		}
		else{
			return false;
		}
    };

    this.compare = function(thisLetterCount, otherLetterCount){
        if(otherLetterCount === undefined){
            return -1;
        }
        if(otherLetterCount === null){
            return -1;
        }
        if(otherLetterCount.count < thisLetterCount.count){
            return -1;
        }
        if(otherLetterCount.count > thisLetterCount.count){
            return 1;
        }
        if(otherLetterCount.letter > thisLetterCount.letter){
            return -1;
        }
        if(otherLetterCount.letter < thisLetterCount.letter){
            return 1;
        }
        return 0;
    };
};

var LetterCount = function(letter, count){
	this.letter = letter;
	this.count = count;

    this.compare = function(thisLetterCount, otherLetterCount){
        if(otherLetterCount === undefined){
            return -1;
        }
        if(otherLetterCount === null){
            return -1;
        }
        if(otherLetterCount.count < thisLetterCount.count){
            return -1;
        }
        if(otherLetterCount.count > thisLetterCount.count){
            return 1;
        }
        if(otherLetterCount.letter < thisLetterCount.letter){
            return -1;
        }
        if(otherLetterCount.letter > thisLetterCount.letter){
            return 1;
        }
        return 0;
    };
};