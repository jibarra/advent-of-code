var Day5 = function(){
    this.puzzleInput = 'cxdnnyjw';
    this.fullExample1 = 'abc';

    this.run = function(){
        var that = this;
        this.testWithExamples();
        // this.findSecurityDoorPassword(this.puzzleInput);
        this.findStrongerSecurityDoorPassword(this.puzzleInput);
    };

    this.testWithExamples = function(){
        // this.findSecurityDoorPassword(this.fullExample1);
        this.findStrongerSecurityDoorPassword(this.fullExample1);
    };

    this.findSecurityDoorPassword = function(doorId){
        var doorPassword = '';
        var i = 0;

        while(doorPassword.length < 8){
            var md5Hash = md5('' + doorId + i);
            if(this.startsWithFiveZeroes(md5Hash) === true){
                doorPassword += md5Hash.charAt(5);
            }
            i++;
        }

        console.log('Door ' + doorId + ' password: ' + doorPassword);
    };

    this.findStrongerSecurityDoorPassword = function(doorId){
        var doorPassword = '        ';
        var i = 0;

        while(doorPassword.indexOf(' ') !== -1){
            var md5Hash = md5('' + doorId + i);
            if(this.startsWithFiveZeroes(md5Hash) === true){
                var indexForPasswordChar = parseInt(md5Hash.charAt(5));
                if(indexForPasswordChar <= 7 && indexForPasswordChar !== NaN && doorPassword[indexForPasswordChar] === ' '){
                    doorPassword = doorPassword.substr(0, indexForPasswordChar)
                        + md5Hash[6] + doorPassword.substr(indexForPasswordChar + 1, doorPassword.length);
                }
            }
            i++;
        }

        console.log('Door ' + doorId + ' password: ' + doorPassword);
    };

    this.startsWithFiveZeroes = function(input){
        if(input.indexOf('00000') === 0){
            return true;
        }
        else{
            return false;
        }
    };
};