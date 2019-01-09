package xyz.jangle.oa.ftl.utils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;

public class FreemarkerUtil {
	/**
	 * 通过名称获取模板
	 * @param natemplateFileName
	 * @return
	 * @throws TemplateNotFoundException
	 * @throws MalformedTemplateNameException
	 * @throws ParseException
	 * @throws IOException
	 */
	public Template getTemplete(String natemplateFileName) throws TemplateNotFoundException, MalformedTemplateNameException, ParseException, IOException {
		Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);//这里是对应的你使用jar包的版本号
		configuration.setClassForTemplateLoading(this.getClass(), "");
		Template template = configuration.getTemplate(natemplateFileName);
		return template;
	}
	/**
	 * 打印到控制台
	 * @param templateFileName
	 * @param dataModel
	 */
	public static void print(String templateFileName ,Object dataModel) {
		try {
			FreemarkerUtil f = new FreemarkerUtil();
			Template template = f.getTemplete(templateFileName);
			template.process(dataModel, new PrintWriter(System.out));
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 通过模板创建文件
	 * @param templateFileName	模板文件名称
	 * @param dataModel			数据模型对象（键值）
	 * @param outFileFullPath	输出文件全路径（路径+文件名称+扩展名）
	 */
	public static void createFile(String templateFileName,Object dataModel, String outFileFullPath) {
		try {
			FreemarkerUtil f = new FreemarkerUtil();
			Template template = f.getTemplete(templateFileName);
			FileWriter out = new FileWriter(new File(outFileFullPath));
			template.process(dataModel, out);
			System.out.println("完成文件的创建："+outFileFullPath);
		} catch (TemplateNotFoundException e) {
			e.printStackTrace();
		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}
	/*
	public static void main(String args[]) {
		A a = new A();
		a.setA("aa");
		a.setB("bb");
		a.setC("cc");
		a.setD("dd");
		createFile("demo2.ftl", a, "d:/d/d/aa.html");
		print("demo2.ftl", a);
	}*/

}
