var Day6 = function(){
    this.puzzleInput = 'puzzleInput.txt';
    this.fullExample1 = 'exampleInput1.txt';

    this.run = function(){
        this.testWithExamples();
        this.runAll();
    };

    this.testWithExamples = function(){
        var that = this;
        $.get(that.fullExample1, function(data){
            that.part1(data.split('\n'));
        });
    };

    this.runAll = function(roomInput){
        var that = this;
        $.get(that.puzzleInput, function(data){
            that.part1(data.split('\n'));
        });
    };

    this.part1 = function(lines){
        var characterIndexCounts = this.countCharacters(lines);
        console.log(characterIndexCounts);
        var mostCommonCharacters = this.findMostCommonCharacters(characterIndexCounts);
        console.log(mostCommonCharacters);
        var errorCorrectedMessage = '';
        for(var i = 0; i < mostCommonCharacters.length; i++){
            errorCorrectedMessage += mostCommonCharacters[i].character;
        }
        console.log(errorCorrectedMessage);
    };

    this.countCharacters = function(lines){
        var characterIndexCounts = [];
        for(var i = 0; i < lines.length; i++){
            var line = lines[i];
            for(var j = 0; j < line.length; j++){
                if(characterIndexCounts[j] === undefined){
                    characterIndexCounts.push(new CharacterIndexCount(j));
                    characterIndexCounts[j].characterCounts = new Map();
                }
                if(characterIndexCounts[j].characterCounts.has(line[j]) === true){
                    characterIndexCounts[j].characterCounts.set(line[j],
                        characterIndexCounts[j].characterCounts.get(line[j]) + 1);
                }
                else{
                    characterIndexCounts[j].characterCounts.set(line[j], 1);
                }
            }
        }

        return characterIndexCounts;
    };

    this.findMostCommonCharacters = function(characterIndexCountArray){
        var mostCommonCharacters = [];
        for(var i = 0; i < characterIndexCountArray.length; i++){
            var keyIter = characterIndexCountArray[i].characterCounts.keys();
            var firstKeyValue = keyIter.next().value;
            mostCommonCharacters.push(new CharacterCount(firstKeyValue,
                characterIndexCountArray[i].characterCounts.get(firstKeyValue)));

            var currentItem = keyIter.next();
            while(currentItem.done === false) {
                var currentCount = characterIndexCountArray[i].characterCounts.get(currentItem.value);
                if(mostCommonCharacters[i].count < currentCount){
                    mostCommonCharacters[i].character = currentItem.value;
                    mostCommonCharacters[i].count = currentCount;
                }
                currentItem = keyIter.next();
            }
        }

        return mostCommonCharacters;
    };
};

var CharacterIndexCount = function(index){
    this.index = index;
    //Maps character to the count of that character for this index
    this.characterCounts;
};

var CharacterCount = function(character, count){
    this.character = character;
    this.count = count;
};