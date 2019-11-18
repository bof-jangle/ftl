package xyz.jangle.demoname.dao;

import org.apache.ibatis.annotations.Select;

import xyz.jangle.demoname.model.${beanName};
/**
 * ${tableRemarks} 数据链路层
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
public interface ${beanName}Mapper extends BaseDaoMapper<${beanName}> {
	
	@Select("select id,uuid,create_time as createTime,update_time as updateTime,status,dm_desc as dmDesc,dm_desc2 as dmDesc2 from ${tableName} where id = <#noparse>#{id}</#noparse>")
	${beanName} selectByPrimaryKeyForAnnotation(Long id);

}