package xyz.jangle.oa.jdbc.utils;
 
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
 

public class TableInfoUtil {
	
	/**
	 * 根据数据库的连接参数，获取指定表的列信息：字段名、字段类型、字段注释
	 * @param driver 数据库连接驱动
	 * @param url 数据库连接url
	 * @param user	数据库登陆用户名
	 * @param pwd 数据库登陆密码
	 * @param table	表名
	 * @return Map集合
	 */
	public static List<Map<String, String>> getColumnsInfo(String driver,String url,String user,String pwd,String table){
		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		
		Connection conn = null;		
		DatabaseMetaData dbmd = null;
		
		try {
			conn = getConnections(driver,url,user,pwd);
			
			dbmd = conn.getMetaData();
			ResultSet resultSet = dbmd.getTables(null, "%", table, new String[] { "TABLE" });
			while (resultSet.next()) {
		    	String tableName=resultSet.getString("TABLE_NAME");
		    	String tableRemarks=resultSet.getString("REMARKS");
		    	System.out.println("表名称:"+tableName);
		    	System.out.println("表注释:"+tableRemarks);
//		    	for(int i=1;i<11;i++) {
//		    		System.out.println("表"+i+":"+resultSet.getString(i));
//		    	}
		    	
		    	if(tableName.equals(table)){
		    		ResultSet rs = conn.getMetaData().getColumns(null, getSchema(conn),tableName.toUpperCase(), "%");
		    		System.out.println(rs);
		    		while(rs.next()){
		    			//System.out.println("字段名："+rs.getString("COLUMN_NAME")+"--字段注释："+rs.getString("REMARKS")+"--字段数据类型："+rs.getString("TYPE_NAME"));
		    			Map<String, String> map = new HashMap<String, String>();
		    			String colName = rs.getString("COLUMN_NAME");
		    			map.put("column", colName);		//列名
		    			map.put("beanProperty", column2modelProperty(colName.toLowerCase()));	//对于的javaBean属性
		    			String remarks = rs.getString("REMARKS");
		    			if(remarks == null || remarks.equals("")){
		    				remarks = colName;
		    			}
		    			map.put("remarks",remarks);		//注释
		    			String dbType = rs.getString("TYPE_NAME");
		    			map.put("jdbcType",dbType);		//数据库类型
		    			map.put("javaType", jdbcType2javaType(dbType));	//对应的java类型
		    			result.add(map);
		    		}
		    	}
		    }
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	/**
	 * 根据数据库的连接参数，获取指定表的信息
	 * @param driver 数据库连接驱动
	 * @param url 数据库连接url
	 * @param user	数据库登陆用户名
	 * @param pwd 数据库登陆密码
	 * @param table	表名
	 * @return 表注释
	 */
	public static String getTableRemarks(String driver,String url,String user,String pwd,String table){
		Connection conn = null;		
		DatabaseMetaData dbmd = null;
		try {
			conn = getConnections(driver,url,user,pwd);
			dbmd = conn.getMetaData();
			ResultSet resultSet = dbmd.getTables(null, "%", table, new String[] { "TABLE" });
			while (resultSet.next()) {
		    	String tableName=resultSet.getString("TABLE_NAME");
		    	System.out.println("表名称:"+tableName);
		    	if(tableName.equals(table)){
		    		String tableRemarks=resultSet.getString("REMARKS");
		    		System.out.println("表注释:"+tableRemarks);
		    		return tableRemarks;
		    	}
		    }
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return "";
	}
	
	
	private static String jdbcType2javaType(String dbType) {
		dbType = dbType.toUpperCase();
		switch(dbType){
		case "VARCHAR":
			return "String";
		case "VARCHAR2":
			return "String";
		case "CHAR":
			return "String";
		case "NUMBER":
			return "Long";
		case "INT":
			return "Integer";
		case "SMALLINT":
			return "Integer";
		case "INTEGER":
			return "Integer";
		case "BIGINT":
			return "Long";
		case "DATETIME":
			return "java.util.Date";
		case "TIMESTAMP":
			return "Long";
		case "DATE":
			return "java.util.Date";
		case "BLOB":
			return "byte[]";
		case "CLOB":
			return "String";
		default:
			return "String";
		}
	}
	
	/**
	 * 列名转属性名（驼峰）
	 * @param column
	 * @return
	 */
	public static String column2modelProperty(String column) {
		int i = column.indexOf("_");
		if(i == column.length() -1) {
			return column.substring(0, i);
		}
		if(i == -1) {
			return column;
		}
		if(i+2<column.length()) {
			column = column.substring(0, i)+column.substring(i+1, i+2).toUpperCase()+column.substring(i+2);
		} else {
			column = column.substring(0, i)+column.substring(i+1, i+2).toUpperCase();
		}
		if(column.indexOf("_") != -1) {
			return column2modelProperty(column);
		}
		return column;
	}
	
	/**
	 * 获取数据库连接
	 * @param driver
	 * @param url
	 * @param user
	 * @param pwd
	 * @return
	 * @throws Exception
	 */
	private static Connection getConnections(String driver,String url,String user,String pwd) throws Exception {
		Connection conn = null;
		try {
			Properties props = new Properties();
			props.put("remarksReporting", "true");
			props.put("useInformationSchema", "true");	//用于取得表注释信息
			props.put("user", user);
			props.put("password", pwd);
			Class.forName(driver);
			conn = DriverManager.getConnection(url, props);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return conn;
	}
	
	//其他数据库不需要这个方法 oracle和db2需要  XXX 未测试
	private static String getSchema(Connection conn) throws Exception {
		String schema;
		schema = conn.getMetaData().getUserName();
		if ((schema == null) || (schema.length() == 0)) {
			throw new Exception("ORACLE数据库模式不允许为空");
		}
		return schema.toUpperCase().toString();
	}
 
	public static void main(String[] args) {
		
		//这里是Oracle连接方法
		/*
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl";
		String user = "user";
		String pwd = "1";
		String table = "oa_user";
		*/
		
		//mysql
		String driver = "com.mysql.jdbc.Driver";
		String user = "fline";
		String pwd = "mysql@2018";
		String url = "jdbc:mysql://10.23.0.139:3306/zjoa"
				+ "?useUnicode=true&characterEncoding=UTF-8";
		String table = "oa_flow_type";
		
		List<Map<String, String>> list = getColumnsInfo(driver,url,user,pwd,table);
		System.out.println(list);
		for(Map<String, String> map : list) {
			System.out.println(map);
		}
	}
	
}