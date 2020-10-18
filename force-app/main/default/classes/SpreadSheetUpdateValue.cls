public with sharing class SpreadSheetUpdateValue {
    public String range;
    public String majorDimension;
    public List<List<Object>> values;

    public SpreadSheetUpdateValue(String range, List<List<Object>> values) {
        this.range = range;
        this.majorDimension = 'ROWS';
        this.values = values;
    }
}
