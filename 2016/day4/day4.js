var SecurityObscurity = function(){
	this.puzzleInput = 'puzzleInput.txt';
	this.example1 = "aaaaa-bbb-z-y-x-123[abxyz]";
	this.example2 = "a-b-c-d-e-f-g-h-987[abcde]";
	this.example3 = "not-a-real-room-404[oarel]";
	this.example4 = "totally-real-room-200[decoy]";
	this.example5 = "qzmt-zixmtkozy-ivhz-343";
	this.numberRegex = new RegExp("[0-9]+");

	this.run = function(){
		var that = this;
		this.testWithExamples();
		$.get(that.puzzleInput, function(data){
			that.runAll(data.split('\n'));
		});
	};

	this.testWithExamples = function(){
        // this.isRealRoom(this.example1);
        // this.isRealRoom(this.example2);
        // this.isRealRoom(this.example3);
        // this.isRealRoom(this.example4);

        // var letterGroups = this.example5.split(this.numberRegex);
        // var roomName = letterGroups[0].replace(/-/g, '');
        // var shiftSpaces = parseInt(this.example5.match(this.numberRegex)[0]) % 26;
        // console.log(roomName);
        // console.log(shiftSpaces);
        // var shiftedName = this.shiftCipher(roomName, shiftSpaces);
        // console.log(shiftedName);
	};

	this.runAll = function(roomInput){
		var validLines = this.validSectors(roomInput);

        this.countValidSectorIds(validLines);
        var roomData = this.processShiftCipherOnLines(validLines);

        console.log(roomData);

        for(var i = 0; i < roomData.length; i++){
        	if(roomData[i].roomName.indexOf("northpole") !== -1){
        		console.log(roomData[i]);
			}
		}
    };

	this.processShiftCipherOnLines = function(validLines){
		var roomData = [];
        for(var i = 0; i < validLines.length; i++){
            var letterGroups = validLines[i].split(this.numberRegex);
            var encryptedRoomName = letterGroups[0].replace(/-/g, '');
            var sectorId = parseInt(validLines[i].match(this.numberRegex)[0]);
            var shiftSpaces = parseInt(sectorId) % 26;
			var actualRoomName = this.shiftCipher(encryptedRoomName, shiftSpaces);
            roomData.push(new RoomData(actualRoomName, sectorId));
        }

        return roomData;
	};

	this.shiftCipher = function(encryptedString, shiftSpaces){
		var shiftedString = "";
        //Characters from a-z (97-122)
        for(var i = 0; i < encryptedString.length; i++){
            var currentCharCode = encryptedString.charCodeAt(i) + shiftSpaces;
            if(currentCharCode > 122){
                currentCharCode = 96 + (currentCharCode - 122);
            }
            shiftedString += String.fromCharCode(currentCharCode);
        }
        return shiftedString;
	}

	this.countValidSectorIds = function(validLines){
        var sectorIdSum = 0;

        for(var i = 0; i < validLines.length; i++){
            var sectorId = parseInt(validLines[i].match(this.numberRegex)[0]);
            sectorIdSum += sectorId;
        }

        console.log("Valid sector ID sums: " + sectorIdSum);
	};

	this.validSectors = function(roomInput){
		var validLines = [];
		for(var i = 0; i < roomInput.length; i++){
			if(this.isRealRoom(roomInput[i])){
                validLines.push(roomInput[i]);
			}
        }

		return validLines;
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

var RoomData = function(roomName, sectorId){
	this.roomName = roomName;
	this.sectorId = sectorId;
};