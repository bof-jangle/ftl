package test;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import xyz.jangle.oa.ftl.utils.FreemarkerUtil;
import xyz.jangle.oa.jdbc.utils.TableInfoUtil;
import xyz.jangle.oa.xmlappend.XmlAppendUtils;

public class ZJOAM {
	
//	public static String tableName = null;					//指定数据库表名称
	public static String runTimeName = "com.fline.zjoa.runtime";		//用于生成前端代码
	public static String coreName = "com.fline.zjoa.core";			//用于生成后端代码
	public static String xmlPath = "cfg";							//配置文件路径
	public static String strutsXmlName = "struts-system.xml";		//struts文件名称
	public static String businessXmlName = "applicationContext-business-core.xml";	//业务层xml名称
	public static String accessXmlName = "applicationContext-access-core.xml";		//dao层xml名称
	public static String driver = "com.mysql.jdbc.Driver";			//指定数据库驱动
	public static String user = "fline";								//用户
	public static String pwd = "mysql@2018";							//密码
	public static String url = "jdbc:mysql://10.23.0.139:3306/zjoa"
			+ "?useUnicode=true&characterEncoding=UTF-8";	//数据库连接地址
	
	
	public static Boolean model = true;
	public static Boolean access = true;
	public static Boolean mgmt = true;
	public static Boolean action = true;
	public static Boolean jsp = true;
	public static Boolean mgmtTest = true;

	public static void main(String[] args) {
		buildFile("oa_test");
//		buildFile("act_ru_task");
//		buildFile("oa_zxta_reader");
//		buildFile("oa_group_dep_r");
//		buildFile("oa_group_user_r");
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
		String strutsXmlFullName = System.getProperty("user.dir")+"/../"+coreName+"/"+xmlPath+"/"+ZJOAM.strutsXmlName;			//拼接全路径
		String businessXmlFullName = System.getProperty("user.dir")+"/../"+coreName+"/"+xmlPath+"/"+ZJOAM.businessXmlName;
		String accessXmlFullName = System.getProperty("user.dir")+"/../"+coreName+"/"+xmlPath+"/"+ZJOAM.accessXmlName;
		String beanNameVar = TableInfoUtil.column2modelProperty(tableName);								//获取表名对应的model变量名称
		String beanName = beanNameVar.substring(0, 1).toUpperCase()+beanNameVar.substring(1);			//获取表名对应的model类型名称
		List<Map<String, String>> list = TableInfoUtil.getTableInfo(driver,url,user,pwd,tableName);		//获取表中的列信息
		if(list == null || list.size() == 0) {
			System.out.println("未取得表的列信息");
			return;
		}
		Map<String, Object> dataModel = new HashMap<String, Object>();	//构建模板所需的dataModel
		dataModel.put("columnList", list);			//column列表
		dataModel.put("beanName", beanName);			//类名
		dataModel.put("beanNameVar", beanNameVar);	//类的变量名
		dataModel.put("tableName", tableName);		//表名
		
		System.out.println("模型数据dataModel"+dataModel);
//		print(map);
		if(model) {
			System.out.println("开始生成model");
			FreemarkerUtil.createFile("flineZjoaModel.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/model/"+beanName+".java");
			System.out.println("开始生成xml");
			FreemarkerUtil.createFile("ibatisXml.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/model/mysql/"+beanName+".xml");
		}
		if(access) {
			System.out.println("开始生成access，以及配置文件的bean");
			FreemarkerUtil.createFile("flineZjoaAccess.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/service/"+beanName+"AccessService.java");
			FreemarkerUtil.createFile("flineZjoaAccessImpl.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/service/impl/"+beanName+"AccessServiceImpl.java");
			XmlAppendUtils.addAccessXml(accessXmlFullName, beanNameVar, beanName);
		}
		if(mgmt) {
			System.out.println("开始生成mgmt，以及配置文件的bean");
			FreemarkerUtil.createFile("flineZjoaMgmt.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/mgmt/service/"+beanName+"MgmtService.java");
			FreemarkerUtil.createFile("flineZjoaMgmtImpl.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/mgmt/service/impl/"+beanName+"MgmtServiceImpl.java");
			XmlAppendUtils.addBunissXml(businessXmlFullName, beanNameVar, beanName);
		}
		if(action) {
			System.out.println("开始生成Action，以及配置文件的action");
			FreemarkerUtil.createFile("flineZjoaAction.ftl", dataModel, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/action/"+beanName+"Action.java");
			XmlAppendUtils.addStrutsXml(strutsXmlFullName, beanNameVar, beanName);
		}
		if(jsp) {
			System.out.println("检测并生成前端页面目录");
			String jspPath = System.getProperty("user.dir")+"/../"+runTimeName+"/web/childPage/"+beanNameVar;
			File jspPathFile = new File(jspPath);
			if(!jspPathFile.exists()) {
				System.out.println("生成目录:"+jspPath);
				jspPathFile.mkdirs();
			}
			System.out.println("开始生成前端jsp页面");
			FreemarkerUtil.createFile("flineZjoaListJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"List.jsp");
			FreemarkerUtil.createFile("flineZjoaEditJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"Edit.jsp");
			FreemarkerUtil.createFile("flineZjoaOpenJsp.ftl", dataModel, jspPath+"/"+beanNameVar+"Open.jsp");
		}
		if(mgmtTest) {
			System.out.println("开始生成单元测试");
			FreemarkerUtil.createFile("flineZjoaMgmtImplTest.ftl", dataModel, System.getProperty("user.dir")+"/../"+runTimeName+"/test/com/fline/zjoa/mgmt/service/impl/"+beanName+"MgmtServiceImplTest.java");
		}
	}
	/**
	 * 打印模板
	 * @param dataModel
	 */
	public static void print(Map<String, String> dataModel) {
		FreemarkerUtil.print("ibatisXml.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaModel.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaAccess.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaAccessImpl.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaMgmt.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaMgmtImpl.ftl", dataModel);
		FreemarkerUtil.print("flineZjoaAction.ftl", dataModel);
	}

	

}
