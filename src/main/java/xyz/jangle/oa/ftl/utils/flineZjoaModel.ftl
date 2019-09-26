package com.fline.zjoa.access.model;

import com.feixian.tp.model.LifecycleModel;
/**
 * 	${tableRemarks} Model对象
 * @author huhj
 * @version ${versionInfo}
 */
public class ${beanName} extends LifecycleModel {

	private static final long serialVersionUID = 1L;
	
	public static final String tableName = "${tableName}";

	<#list columnList as row>
	<#if row.beanProperty != "id">
	
	/**
	 * ${row.remarks}
	 */
	private ${row.javaType} ${row.beanProperty};
	</#if>
	</#list>
	
	public void setId(Long id) {
		if(null == id) {
			this.id = 0;
		} else {
			this.id = id;
		}
	}
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
