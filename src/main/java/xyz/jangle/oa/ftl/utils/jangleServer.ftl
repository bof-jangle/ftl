package xyz.jangle.demoname.service;

import java.util.Map;

import xyz.jangle.demoname.model.${beanName};
import xyz.jangle.utils.ResultModel;
import xyz.jangle.utils.ResultModelList;

/**
 * ${tableRemarks} 业务层
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
public interface ${beanName}Service {
	/**
	 * 	增
	 *
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> insertOrUpdate(${beanName} record);

	/**
	 * 	删
	 *
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> deleteByPrimaryKey(${beanName} record);

	/**
	 *	改
	 *
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> updateByPrimaryKey(${beanName} record);

	/**
	 * 	单查
	 *
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> selectByPrimaryKey(${beanName} record);

	/**
	 * 	参查
	 *
	 * @param param
	 * @return
	 */
	ResultModelList<${beanName}> selectByParam(Map<String, Object> param);

	/**
	 * 	分查
	 *
	 * @param record
	 * @return
	 */
	ResultModelList<${beanName}> selectPage(${beanName} record);

	/**
	 * 	全询
	 *
	 * @return
	 */
	ResultModelList<${beanName}> selectAll();

	/**
	 * 	批删
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> batchDeleteByPrimaryKey(${beanName} record);

	/**
	 * 	批删Actually
	 * @param record
	 * @return
	 */
	ResultModel<${beanName}> batchDeleteByPrimaryKeyActually(${beanName} record);

	/**
	 * 	注解查（注解方式）
	 * @return
	 */
	ResultModel<${beanName}> selectByPrimaryKeyForAnnotation(${beanName} record);

}
