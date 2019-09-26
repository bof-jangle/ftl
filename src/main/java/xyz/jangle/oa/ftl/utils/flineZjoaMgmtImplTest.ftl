package com.fline.zjoa.mgmt.service.impl;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.feixian.tp.common.vo.Ordering;
import com.feixian.tp.common.vo.Pagination;
import com.fline.zjoa.access.model.${beanName};
import com.fline.zjoa.mgmt.service.${beanName}MgmtService;
import com.fline.zjoa.util.OaConstant;
import com.fline.zjoa.util.OaRM;
import com.fline.zjoa.utils.JUnitRuntimeSupport;
/**
 * 	${tableRemarks} 单元测试
 * @author huhj
 * @version ${versionInfo}
 */
public class ${beanName}MgmtServiceImplTest extends JUnitRuntimeSupport {

	// 用于保存方法调用前，新增的记录。
	private static ${beanName} testModel;

	@Autowired
	private ${beanName}MgmtService ${beanNameVar}MgmtService;

	@Before
	public void setUp() throws Exception {
		userLogin();
		${beanName} model = new ${beanName}();
		Map<String, Object> result = ${beanNameVar}MgmtService.add${beanName}(model);
		assertEquals(OaRM.success, result.get(OaRM.rm));
		testModel = (${beanName})result.get(OaConstant.result);
		assertNotNull(testModel);
	}

	@After
	public void tearDown() throws Exception {
		testModel = null;
		userLogin();
	}

	@Test
	public void testFindPagination() {
		Map<String, Object> param = new HashMap<String, Object>(); // 查询参数
		Pagination<${beanName}> page = new Pagination<${beanName}>(); // 分页参数
		Ordering order = new Ordering(); // 排序参数
		Pagination<${beanName}> findPagination = ${beanNameVar}MgmtService.findPagination(param, order,
				page);
		assertFalse(findPagination.getItems().isEmpty());
	}

	@Test
	public void testAdd${beanName}() {
		${beanNameVar}MgmtService.add${beanName}(testModel);
	}

	@Test
	public void testRemove${beanName}() {
		assertNotNull(${beanNameVar}MgmtService.findById(testModel));
		${beanNameVar}MgmtService.remove${beanName}(testModel);
		assertNull(${beanNameVar}MgmtService.findById(testModel));
	}

	@Test
	public void testUpdate${beanName}() {
		${beanNameVar}MgmtService.update${beanName}(testModel);
		assertNotNull(${beanNameVar}MgmtService.findById(testModel));
	}

}
