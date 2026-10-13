public class vowelconsonentseparation {
    public static void separateletters(string input){
        string vowels='';
        string consonents='';
        for (Integer i = 0; i < input.length(); i++){
            string ch=input.substring(i,i+1).toLowerCase();
            if (ch>='a' &&  ch<='z'){
                if('aeiou'.contains(ch)){
                    vowels+=ch;
                }
                else {
                    consonents+=ch;
                }
                }
            }
            system.debug(vowels);
            System.debug(consonents);

        }

    }
    
