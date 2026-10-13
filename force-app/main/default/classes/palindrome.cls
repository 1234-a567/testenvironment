public with sharing class palindrome {
    public static void reverse(string input){
        string reversestring='';
        for (Integer i = input.length()-1; i >= 0; i--) {
            reversestring += input.substring(i, i + 1);
        }
        if (input.toLowerCase() == reversestring.toLowerCase()) {
            System.debug('It is a palindrome');
        } else {
            System.debug('It is not a palindrome');
        }
    }

}