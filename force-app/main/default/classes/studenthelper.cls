public class studenthelper {
    // Method that returns a map of month abbreviations to month numbers
    public static Map<String, Integer> getMonthVsNumberMap() {
        Map<String, Integer> monthNameVsNumber = new Map<String, Integer>();

        monthNameVsNumber.put('Jan', 1);
        monthNameVsNumber.put('Feb', 2);
        monthNameVsNumber.put('Mar', 3);
        monthNameVsNumber.put('Apr', 4);
        monthNameVsNumber.put('May', 5);
        monthNameVsNumber.put('Jun', 6);
        monthNameVsNumber.put('Jul', 7);
        monthNameVsNumber.put('Aug', 8);
        monthNameVsNumber.put('Sep', 9);
        monthNameVsNumber.put('Oct', 10);
        monthNameVsNumber.put('Nov', 11);
        monthNameVsNumber.put('Dec', 12);  

        return monthNameVsNumber;
    }
}