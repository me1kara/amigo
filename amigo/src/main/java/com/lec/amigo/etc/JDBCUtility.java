package com.lec.amigo.etc;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;

public class JDBCUtility {
	@Value("jdbc.driver")
	private static String driver;
	@Value("jdbc.url")
	private static String url;
	@Value("jdbc.user")
	private static String user;
	@Value("jdbc.pwd")
	private static String pwd;
	
	public static Connection getConnection(){
		Connection conn = null;	
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pwd);
			conn.setAutoCommit(false);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return conn;	
	}
	
	public static void close(Connection conn, ResultSet rs, Statement stmt) {
		
		if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
		if(stmt!=null)try {stmt.close();} catch (SQLException e) {e.printStackTrace();}
		if(conn!=null)try {conn.close();} catch (SQLException e) {e.printStackTrace();}
		
	}
	
	public static void rollback(Connection conn) {
		if(conn!=null)try {conn.rollback();} catch (SQLException e) {e.printStackTrace();}
	}
	
	public static void commit(Connection conn) {
		if(conn!=null)try {conn.commit();} catch (SQLException e) {e.printStackTrace();}
	}

}
