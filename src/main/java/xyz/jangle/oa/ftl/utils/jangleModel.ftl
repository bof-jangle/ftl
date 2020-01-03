package xyz.jangle.demoname.model;

/**
 * ${tableRemarks} Model
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
public class ${beanName} extends BaseModel {
	
	public static final String tableName = "${tableName}";

	<#list columnList as row>
	<#if row.beanProperty != "id">
	/**
	 * ${row.remarks}
	 */
	private ${row.javaType} ${row.beanProperty};
	</#if>
	</#list>
	
	<#list columnList as row>
	<#if row.beanProperty != "id">
	public ${row.javaType} get${row.beanProperty?cap_first}(){
		return ${row.beanProperty};
	}
	public void set${row.beanProperty?cap_first}(${row.javaType} ${row.beanProperty}){
		this.${row.beanProperty} = ${row.beanProperty};
	}
	</#if>
	</#list>
	
	
}