package de.vogella.sap.jco.adapter;

import com.sap.conn.jco.JCoTable;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * TableAdapter is used to simplify the reading of the values of the Jco tables
 */
public class TableAdapterReader {
    private final JCoTable table;

    public TableAdapterReader(JCoTable table) {
        this.table = table;
    }

    public String get(String s) {
        return (table.getValue(s) == null) ? null :
                table.getValue(s).toString();
    }

    private Calendar getDate(String s) {
        if(table.getValue(s) == null){
            return null;
        }
        Date date = table.getDate(s);
        Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return cal;
    }

    public String getDate(String s, String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Calendar cal = getDate(s);
        if(null == cal){
            return null;
        }
        sdf.setCalendar(cal);
        return sdf.format(cal.getTime());
    }

    public boolean isBoolean(String s) {
        String value = table.getValue(s).toString();
        return "X".equals(value);
    }

    public String getMessage() {
        return table.getString("MESSAGE");
    }

    public int size() {
        return table.getNumRows();
    }

    public void next() {
        table.nextRow();
    }
}