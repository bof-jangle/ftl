package com.fline.zjoa.mgmt.service.impl;

import java.util.Map;

import com.feixian.tp.common.vo.Ordering;
import com.feixian.tp.common.vo.Pagination;
import com.fline.oa.utils.ServiceSupport;
import com.fline.zjoa.access.model.${beanName};
import com.fline.zjoa.access.service.${beanName}AccessService;
import com.fline.zjoa.mgmt.service.${beanName}MgmtService;
/**
 * <!-- 工具1.0生成 -->
 * @author huhj
 *
 */
public class ${beanName}MgmtServiceImpl extends ServiceSupport implements ${beanName}MgmtService {

	private ${beanName}AccessService ${beanNameVar}AccessService;

	@Override
	public Pagination<${beanName}> findPagination(Map<String, Object> param, Ordering order, Pagination<${beanName}> page) {
		return ${beanNameVar}AccessService.findPagination(param, order, page);
	}

	@Override
	public Map<String, Object> add${beanName}(${beanName} ${beanNameVar}) {
		map.put("result", ${beanNameVar}AccessService.save(${beanNameVar}));
		map.put(OaRM.rm, OaRM.success);
		return map;
	}

	@Override
	public ${beanName} remove${beanName}(${beanName} ${beanNameVar}) {
		return ${beanNameVar}AccessService.remove(${beanNameVar});
	}

	@Override
	public ${beanName} update${beanName}(${beanName} ${beanNameVar}) {
		return ${beanNameVar}AccessService.update(${beanNameVar});
	}

	@Override
	public ${beanName} findById(${beanName} ${beanNameVar}) {
		return ${beanNameVar}AccessService.findById(${beanNameVar}.getId());
	}

	public void set${beanName}AccessService(${beanName}AccessService ${beanNameVar}AccessService) {
		this.${beanNameVar}AccessService = ${beanNameVar}AccessService;
	}

}
