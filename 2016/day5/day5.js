var Day5 = function(){
    this.puzzleInput = 'cxdnnyjw';
    this.fullExample1 = 'abc';

    this.run = function(){
        var that = this;
        // this.testWithExamples();
        this.findSecurityDoorPassword(this.puzzleInput);
    };

    this.testWithExamples = function(){
        // var test = md5('abc3231929');
        // console.log(test);
        // var hasFiveZeroStart = this.startsWithFiveZeroes(test);
        // console.log(hasFiveZeroStart);
        this.findSecurityDoorPassword(this.fullExample1);
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

    this.startsWithFiveZeroes = function(input){
        if(input.indexOf('00000') === 0){
            return true;
        }
        else{
            return false;
        }
    };
};