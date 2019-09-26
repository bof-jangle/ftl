package com.fline.zjoa.access.service;

import com.feixian.aip.platform.access.common.service.AbstractNamespaceAccessService;
import com.fline.zjoa.access.model.${beanName};
/**
 * 	${tableRemarks} DAO接口层
 * @author huhj
 * @version ${versionInfo}
 */
public interface ${beanName}AccessService extends AbstractNamespaceAccessService<${beanName}> {
	/**
	 * 根据uuid查询记录
	 * @param uuid
	 * @return
	 */
	${beanName} findByOaUuid(String oaUuid);
}