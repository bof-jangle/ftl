package xyz.jangle.demoname.service.impl;

import static org.junit.Assert.*;

import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import xyz.jangle.demoname.model.${beanName};
import xyz.jangle.demoname.service.${beanName}Service;
import xyz.jangle.test.utils.JUnitRunSupport;
import xyz.jangle.utils.CME;
import xyz.jangle.utils.Jutils;
import xyz.jangle.utils.ResultModel;

/** 
* ${tableRemarks} 单元测试
* @author jangle E-mail: jangle@jangle.xyz
* @version ${versionInfo}
* 类说明 
*/
public class ${beanName}ServiceImplTest extends JUnitRunSupport {
	
	@Autowired
	private ${beanName}Service ${beanNameVar}Service;
	
	private ${beanName} test${beanName} = null;
	
	private final String testString = "jangleTest";

	@Before
	public void setUp() throws Exception {
		${beanName} record = new ${beanName}();
		record.setDmDesc(testString);
		ResultModel<${beanName}> resultModel = ${beanNameVar}Service.insertOrUpdate(record );
		test${beanName} = resultModel.getModel();
	}

	@After
	public void tearDown() throws Exception {
	}
	
	@Test
	public void testInsert() {
		test${beanName}.setId(0L);	//根据UUID更新
		assertEquals(CME.success.getCode(), ${beanNameVar}Service.insertOrUpdate(test${beanName}).getCode());
		test${beanName}.setId(1L);	//无对应的主键记录报错
		assertEquals(CME.error.getCode(), ${beanNameVar}Service.insertOrUpdate(test${beanName}).getCode());
	}

	@Test
	public void testDeleteByPrimaryKey() {
		assertNotNull(${beanNameVar}Service.selectByPrimaryKey(test${beanName}).getModel());
		assertEquals(CME.success.getCode(), ${beanNameVar}Service.deleteByPrimaryKey(test${beanName}).getCode());
		assertEquals("2", ${beanNameVar}Service.selectByPrimaryKey(test${beanName}).getModel().getStatus().toString());
		test${beanName}.setId(1L);
		assertEquals(CME.error.getCode(), ${beanNameVar}Service.deleteByPrimaryKey(test${beanName}).getCode());
	}

	@Test
	public void testSelectAll() {
		assertFalse(${beanNameVar}Service.selectAll().getList().isEmpty());
	}

	@Test
	public void testSelectByParam() {
		Map<String, Object> param = Jutils.getHashMapSO();
		param.put("dmDesc", testString);
		assertFalse(${beanNameVar}Service.selectByParam(param).getList().isEmpty());
		param.put("dmDesc", "&^%$*&");
		assertEquals(CME.success.getCode(), ${beanNameVar}Service.selectByParam(param).getCode());
	}

	@Test
	public void testUpdateByPrimaryKey() {
		assertEquals(testString, ${beanNameVar}Service.selectByPrimaryKey(test${beanName}).getModel().getDmDesc());
		test${beanName}.setDmDesc("updateDesc");
		${beanNameVar}Service.updateByPrimaryKey(test${beanName});
		assertFalse(${beanNameVar}Service.selectByPrimaryKey(test${beanName}).getModel().getDmDesc().equals(testString));
		test${beanName}.setId(0L);
		test${beanName}.setUuid("");
		${beanNameVar}Service.updateByPrimaryKey(test${beanName}).getCode().equals(CME.error.getCode());
	}

	@Test
	public void testSelectPage() {
		assertFalse(${beanNameVar}Service.selectPage(new ${beanName}()).getList().isEmpty());
	}
	
	@Test
	public void testSelectByPrimaryKey() {
		${beanNameVar}Service.selectByPrimaryKey(test${beanName});
	}
	
	@Test
	public void testBatchDeleteByPrimaryKey() {
		${beanName} record = new ${beanName}();
		assertEquals(CME.unFindIdsToDelete.getCode(), ${beanNameVar}Service.batchDeleteByPrimaryKey(record).getCode());
		record.setIds(test${beanName}.getId().toString());
		${beanNameVar}Service.batchDeleteByPrimaryKey(record);
		assertEquals("2", ${beanNameVar}Service.selectByPrimaryKey(test${beanName}).getModel().getStatus().toString());
	}
	
	@Test
	public void testSelectByPrimaryKeyForAnnotation(){
		assertNotNull(${beanNameVar}Service.selectByPrimaryKeyForAnnotation(test${beanName}));
	}

}
