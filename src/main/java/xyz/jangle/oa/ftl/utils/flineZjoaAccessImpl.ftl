package com.fline.zjoa.access.service.impl;

import com.feixian.aip.platform.access.common.service.impl.AbstractNamespaceAccessServiceImpl;
import com.fline.zjoa.access.model.${beanName};

import com.fline.zjoa.access.service.${beanName}AccessService;
/**
 * 	${tableRemarks}	DAO实现层
 * @author huhj
 * @version ${versionInfo}
 */
public class ${beanName}AccessServiceImpl extends AbstractNamespaceAccessServiceImpl<${beanName}> implements ${beanName}AccessService {
	
	@Override
	public ${beanName} findByOaUuid(String oaUuid) {
		${beanName} ${beanNameVar} = new ${beanName}();
		${beanNameVar}.setOaUuid(oaUuid);
		return this.getIbatisDataAccessObject().findOne(namespace, "findByOaUuid", ${beanNameVar});
	}
}