package test;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import xyz.jangle.oa.ftl.utils.FreemarkerUtil;
import xyz.jangle.oa.jdbc.utils.TableInfoUtil;

public class JangleM {
	
//	public static String tableName = null;					//指定数据库表名称
	public static String webappName = "../workspace2018June/webapp";			//用于生成后端代码
	public static String xmlPath = "/src/main/resources";							//配置文件路径
	public static String driver = "com.mysql.jdbc.Driver";			//指定数据库驱动
	public static String user = "jangle";								//用户
	public static String pwd = "";							//密码
	public static String url = "jdbc:mysql://hello.jangle.xyz:3306/demo"
			+ "?characterEncoding=UTF8";	//数据库连接地址
	
	
	public static Boolean model = true;
	public static Boolean daos = true;
	public static Boolean servers = true;
	public static Boolean ctrl = true;
	public static Boolean jsp = true;
	public static Boolean serversTest = true;

	public static void main(String[] args) {
//		buildFile("bs_role");
	}
	/**
	 * 
	 * 根据表名，创建代码
	 */
	public static void buildFile(String tableName) {
		if(tableName == null || tableName == "") {
			System.out.println("未指定数据库表名");
			return;
		}
//		String strutsXmlFullName = System.getProperty("user.dir")+"/../"+coreName+"/"+xmlPath+"/"+JangleM.strutsXmlName;			//拼接全路径
		String beanNameVar = TableInfoUtil.column2modelProperty(tableName);								//获取表名对应的model变量名称
		String beanName = beanNameVar.substring(0, 1).toUpperCase()+beanNameVar.substring(1);			//获取表名对应的model类型名称
		String tableRemarks = TableInfoUtil.getTableRemarks(driver, url, user, pwd, tableName);			//获取表的注释信息
		List<Map<String, String>> list = TableInfoUtil.getColumnsInfo(driver,url,user,pwd,tableName);		//获取表中的列信息
		if(list == null || list.size() == 0) {
			System.out.println("未取得表的列信息");
			return;
		}
		Map<String, Object> dataModel = new HashMap<String, Object>();	//构建模板所需的dataModel
		dataModel.put("columnList", list);			//column列表
		dataModel.put("beanName", beanName);			//类名
		dataModel.put("beanNameVar", beanNameVar);	//类的变量名
		dataModel.put("tableName", tableName);		//表名
		dataModel.put("tableRemarks", tableRemarks);//表注释
		dataModel.put("ywdh", ",");
		dataModel.put("mybatisLeft", "#{");
		dataModel.put("mybatisRight", "}");
		dataModel.put("versionInfo", "Jangle生成工具v1.1");
		
		System.out.println("模型数据dataModel"+dataModel);
//		print(dataModel);
		if(model) {
			System.out.println("开始生成model");
			FreemarkerUtil.createFile("jangleModel.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/model/"+beanName+".java");
		}
		if(daos) {
			System.out.println("开始生成Dao");
			FreemarkerUtil.createFile("jangleDao.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/dao/"+beanName+"Mapper.java");
			System.out.println("开始生成Mapper.xml");
			FreemarkerUtil.createFile("jangleMapper.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/mapper/"+beanName+"Mapper.xml");
		}
		if(servers) {
			System.out.println("开始生成server");
			FreemarkerUtil.createFile("jangleServer.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/service/"+beanName+"Service.java");
			FreemarkerUtil.createFile("jangleServerImpl.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/service/impl/"+beanName+"ServiceImpl.java");
		}
		if(ctrl) {
			System.out.println("开始生成控制层");
			FreemarkerUtil.createFile("jangleCtrl.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/main/java/xyz/jangle/demoname/ctrl/"+beanName+"Ctrl.java");
		}
		if(jsp) {
			System.out.println("检测并生成前端页面目录");
			String jspPath = System.getProperty("user.dir")+"/../"+webappName+"/src/main/webapp/mgmt/"+beanNameVar;
			File jspPathFile = new File(jspPath+"/js");
			if(!jspPathFile.exists()) {
				System.out.println("生成目录:"+jspPath+"/js");
				jspPathFile.mkdirs();
			}
			System.out.println("开始生成前端jsp页面");
			FreemarkerUtil.createFile("jangleListJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"List.jsp");
			FreemarkerUtil.createFile("jangleEditJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"Edit.jsp");
			FreemarkerUtil.createFile("jangleOpenJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"Open.jsp");
			FreemarkerUtil.createFile("jangleEditJs.ftl", dataModel, jspPath+"/js/"+beanNameVar+"Edit.js");
		}
		if(serversTest) {
			System.out.println("开始生成单元测试");
			FreemarkerUtil.createFile("jangleServerImplTest.ftl", dataModel, System.getProperty("user.dir")+"/../"+webappName+"/src/test/java/xyz/jangle/demoname/service/impl/"+beanName+"ServiceImplTest.java");
		}
	}
	/**
	 * 打印模板
	 * @param dataModel
	 */
	public static void print(Map<String, Object> dataModel) {
		FreemarkerUtil.print("jangleModel.ftl", dataModel);
		FreemarkerUtil.print("jangleDao.ftl", dataModel);
		FreemarkerUtil.print("jangleMapper.ftl", dataModel);
		FreemarkerUtil.print("jangleServer.ftl", dataModel);
		FreemarkerUtil.print("jangleServerImpl.ftl", dataModel);
		FreemarkerUtil.print("jangleCtrl.ftl", dataModel);
	}

	

}
