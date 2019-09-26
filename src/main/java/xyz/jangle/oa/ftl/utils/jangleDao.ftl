package xyz.jangle.demoname.dao;

import org.apache.ibatis.annotations.Select;

import xyz.jangle.demoname.model.${beanName};
/**
 * ${tableRemarks} 数据链路层
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
public interface ${beanName}Mapper extends BaseDaoMapper<${beanName}> {
	
	@Select("select * from ${tableName} where id = <#noparse>#{id}</#noparse>")
	${beanName} selectByPrimaryKeyForAnnotation(Long id);

}