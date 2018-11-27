package test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import xyz.jangle.oa.ftl.utils.FreemarkerUtil;
import xyz.jangle.oa.jdbc.utils.TableInfoUtil;
import xyz.jangle.oa.xmlappend.XmlAppendUtils;

public class M {

	public static void main(String[] args) {
		
		String tableName = "oa_flow_type_copy";					//指定数据库表名称
		String runTimeName = "com.fline.zjoa.runtime";		//用于生成前端代码
		String coreName = "com.fline.zjoa.core";			//用于生成后端代码
		String strutsXmlName = System.getProperty("user.dir")+"/../com.fline.zjoa.core/cfg/struts-system.xml";
		String businessXmlName = System.getProperty("user.dir")+"/../com.fline.zjoa.core/cfg/applicationContext-business-core.xml";
		String accessXmlName = System.getProperty("user.dir")+"/../com.fline.zjoa.core/cfg/applicationContext-access-core.xml";
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		String driver = "com.mysql.jdbc.Driver";			//指定数据库驱动
		String user = "fline";								//用户
		String pwd = "mysql@2018";							//密码
		String url = "jdbc:mysql://10.23.0.139:3306/zjoa"
				+ "?useUnicode=true&characterEncoding=UTF-8";	//数据库连接地址
		String beanNameVar = TableInfoUtil.column2modelProperty(tableName);
		String beanName = beanNameVar.substring(0, 1).toUpperCase()+beanNameVar.substring(1);
		List<Map<String, String>> list = TableInfoUtil.getTableInfo(driver,url,user,pwd,tableName);

		map.put("columnList", list);			//column列表
		map.put("beanName", beanName);		//类名
		map.put("beanNameVar", beanNameVar);	//类的变量名
		map.put("tableName", tableName);			//表名
		
		System.out.println(map);
		
//		FreemarkerUtil.print("ibatisXml.ftl", map);
//		FreemarkerUtil.print("flineZjoaModel.ftl", map);
//		FreemarkerUtil.print("flineZjoaAccess.ftl", map);
//		FreemarkerUtil.print("flineZjoaAccessImpl.ftl", map);
//		FreemarkerUtil.print("flineZjoaMgmt.ftl", map);
//		FreemarkerUtil.print("flineZjoaMgmtImpl.ftl", map);
//		FreemarkerUtil.print("flineZjoaAction.ftl", map);
		System.out.println("开始生成xml");
		FreemarkerUtil.createFile("ibatisXml.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/model/mysql/"+beanName+".xml");
		System.out.println("开始生成model");
		FreemarkerUtil.createFile("flineZjoaModel.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/model/"+beanName+".java");
		System.out.println("开始生成access");
		FreemarkerUtil.createFile("flineZjoaAccess.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/service/"+beanName+"AccessService.java");
		FreemarkerUtil.createFile("flineZjoaAccessImpl.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/access/service/impl/"+beanName+"AccessServiceImpl.java");
		XmlAppendUtils.addBunissXml(accessXmlName, beanNameVar, beanName);
		System.out.println("开始生成mgmt");
		FreemarkerUtil.createFile("flineZjoaMgmt.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/mgmt/service/"+beanName+"MgmtService.java");
		FreemarkerUtil.createFile("flineZjoaMgmtImpl.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/mgmt/service/impl/"+beanName+"MgmtServiceImpl.java");
		XmlAppendUtils.addBunissXml(businessXmlName, beanNameVar, beanName);
		System.out.println("开始生成Action");
		FreemarkerUtil.createFile("flineZjoaAction.ftl", map, System.getProperty("user.dir")+"/../"+coreName+"/src/com/fline/zjoa/action/"+beanName+"Action.java");
		System.out.println("开始向struts配置文件添加Action");
		XmlAppendUtils.addStrutsXml(strutsXmlName, beanNameVar, beanName);
	}

}
