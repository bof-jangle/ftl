package com.fline.zjoa.mgmt.service;

import java.util.Map;

import com.feixian.tp.common.vo.Ordering;
import com.feixian.tp.common.vo.Pagination;
import com.fline.zjoa.access.model.${beanName};
/**
 * <!-- 工具1.0生成 -->
 * @author huhj
 *
 */
public interface ${beanName}MgmtService {
	/**
	 * 分页查询
	 * @param param
	 * @param order
	 * @param page
	 * @return
	 */
	Pagination<${beanName}> findPagination(Map<String, Object> param, Ordering order, Pagination<${beanName}> page);

	/**
	 * 添加记录
	 * @param ${beanNameVar}
	 * @return
	 */
	Map<String, Object> add${beanName}(${beanName}  ${beanNameVar});
	/**
	 * 删除记录
	 * @param ${beanNameVar}
	 * @return
	 */
	${beanName} remove${beanName}(${beanName} ${beanNameVar});
	/**
	 * 更新记录
	 * @param ${beanNameVar}
	 * @return
	 */
	${beanName} update${beanName}(${beanName} ${beanNameVar});
	/**
	 * 根据id查询
	 * @param ${beanNameVar}
	 * @return
	 */
	${beanName} findById(${beanName} ${beanNameVar});

}
