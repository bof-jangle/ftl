package xyz.jangle.oa.xmlappend;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class XmlAppendUtils {

	
	/**
	 * 添加access层bean
	 * @param pathAndFileName
	 * @param beanNameVar
	 * @param beanName
	 */
	public static void addAccessXml(String pathAndFileName,String beanNameVar,String beanName) {
		String insertPosition = "</beans>";
		String insertStr = "<bean id=\""+beanNameVar+"AccessService\"\r\n" + 
				"		class=\"com.fline.zjoa.access.service.impl."+beanName+"AccessServiceImpl\"\r\n" + 
				"		parent=\"abstractNamespaceAccessService\">\r\n" + 
				"	</bean>";
		insertStr += "\n</beans>";
		insertContent(pathAndFileName, beanName, insertPosition, insertStr);
	}
	/**
	 * 添加mgmt层bean
	 * @param pathAndFileName
	 * @param beanNameVar
	 * @param beanName
	 */
	public static void addBunissXml(String pathAndFileName,String beanNameVar,String beanName) {
		String insertPosition = "</beans>";
		String insertStr = "	<bean id=\""+beanNameVar+"MgmtService\" class=\"com.fline.zjoa.mgmt.service.impl."+beanName+"MgmtServiceImpl\">\r\n" + 
				"		<property name=\""+beanNameVar+"AccessService\" ref=\""+beanNameVar+"AccessService\" />\r\n" + 
				"	</bean>";
		insertStr += "\n</beans>";
		insertContent(pathAndFileName, beanName, insertPosition, insertStr);
	}
	/**
	 * 添加struts配置项
	 * @param pathAndFileName
	 * @param beanNameVar
	 * @param beanName
	 */
	public static void addStrutsXml(String pathAndFileName,String beanNameVar,String beanName) {
		String insertPosition = "</package>";
		String insertStr = "	<action name=\""+beanNameVar+"Action\" class=\"com.fline.zjoa.action."+beanName+"Action\">\r\n" + 
				"			<result name=\"success\" type=\"json\">\r\n" + 
				"				<param name=\"root\">dataMap</param>\r\n" + 
				"			</result>\r\n" + 
				"		</action>";
		insertStr += "\n	</package>\r\n" + 
				"</struts>";
		insertContent(pathAndFileName, beanName, insertPosition, insertStr);
	}
	/**
	 * 对文件进行内容新增
	 * @param pathAndFileName	文件全路径，路径+文件名+扩展名
	 * @param beanNameVar		类型名变量
	 * @param beanName			类型名称
	 * @param insertPosition	插入位置
	 * @param toInsertStr		插入内容
	 */
	private static void insertContent(String pathAndFileName,String beanName,String insertPosition,String toInsertStr) {
		File file = new File(pathAndFileName);
		try {
			FileInputStream in = new FileInputStream(file);
			byte[] b = new byte[in.available()];
			in.read(b);
			in.close();
			String content = new String(b);
			if(content.indexOf(beanName) != -1) {
				System.out.println("认为已经存在该对象对应的配置项");
				return;
			}
			// 不出现该对象则进行新增
			int indexOf = content.indexOf(insertPosition);
			String newContent = content.substring(0, indexOf);
			newContent = newContent + toInsertStr;	//添加新的action
			FileOutputStream out = new FileOutputStream(file,false);	//false 对文件进行重写。  true 向文件添加新内容
			out.write(newContent.getBytes());			//对文件进行重写
			out.flush();
			out.close();
			System.out.println("成功插入文本内容");
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

}
