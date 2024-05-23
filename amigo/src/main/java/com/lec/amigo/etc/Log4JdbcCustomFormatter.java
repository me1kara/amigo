package com.lec.amigo.etc;

import org.apache.commons.lang3.StringUtils;

import net.sf.log4jdbc.Slf4jSpyLogDelegator;
import net.sf.log4jdbc.Spy;
import net.sf.log4jdbc.tools.LoggingType;

public class Log4JdbcCustomFormatter extends Slf4jSpyLogDelegator {

    private LoggingType loggingType = LoggingType.DISABLED;

    private String margin = "";

    private String sqlPrefix = "### KACEDB SQL ### -> ";


    public int getMargin() {
        return margin.length();
    }

    public void setMargin(int n) {
        margin = String.format("%1$#" + n + "s", "");
        //margin = String.format("%1$" + n + "s", "");
    }

    @Override
    public String sqlOccured(Spy spy, String methodCall, String rawSql) {
        if (loggingType == LoggingType.DISABLED) {
            return "";
        }

        // Remove all existing cr lf, unless MULTI_LINE
        if (loggingType != LoggingType.MULTI_LINE) {
            rawSql = rawSql.replaceAll("\r", "");
            rawSql = rawSql.replaceAll("\n", "");
        }

        // 쿼리를 트림하고, 여러개의 공백은 하나로 변경합니다.
        rawSql = rawSql.trim();
        //rawSql = rawSql.replaceAll("\\s+", " ");

        final String fromClause = " FROM ";
        String sql = rawSql;
        if (loggingType == LoggingType.MULTI_LINE) {
        	final String whereClause = " WHERE ";
            final String andClause = " AND ";
            final String orderByClause = " ORDER BY ";
            final String groupByClause = " GROUP BY ";
            final String subSelectClauseS = "\\(SELECT";
            final String subSelectClauseR = " (SELECT";

            sql = sql.replaceAll("(?i)" + fromClause, "\n" + margin + fromClause);
            sql = sql.replaceAll("(?i)" + whereClause, "\n" + margin + whereClause);
            sql = sql.replaceAll("(?i)" + andClause, "\n" + margin + andClause);
            sql = sql.replaceAll("(?i)" + orderByClause, "\n" + margin + orderByClause);
            sql = sql.replaceAll("(?i)" + groupByClause, "\n" + margin + groupByClause);
            sql = sql.replaceAll("(?i)" + subSelectClauseS, "\n" + margin + subSelectClauseR);
        }
        if (loggingType == LoggingType.SINGLE_LINE_TWO_COLUMNS) {
            if (sql.startsWith("select")) {
                String from = sql.substring(sql.indexOf(fromClause) + fromClause.length());
                sql = from + "\t" + sql;
            }
        }

        sql = StringUtils.trimToEmpty(sql);
        //sql = Pattern.compile("^\\RS").mate(cher(sql).replaceAll("");

        getSqlOnlyLogger().info(sqlPrefix + margin + sql);

        return sql;
    }

    @Override
    public String sqlOccured(Spy spy, String methodCall, String[] sqls) {
        String s = "";
        for (int i = 0; i < sqls.length; i++) {
            s += sqlOccured(spy, methodCall, sqls[i]) + String.format("%n");
        }
        return s;
    }

    public LoggingType getLoggingType() {
        return loggingType;
    }

    public void setLoggingType(LoggingType loggingType) {
        this.loggingType = loggingType;
    }

    public String getSqlPrefix()
    {
        return sqlPrefix;
    }

    public void setSqlPrefix(String sqlPrefix)
    {
        this.sqlPrefix = sqlPrefix;
    }
}
