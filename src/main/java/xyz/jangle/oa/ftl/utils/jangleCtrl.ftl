package xyz.jangle.demoname.ctrl;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import xyz.jangle.demoname.model.${beanName};
import xyz.jangle.demoname.service.${beanName}Service;
import xyz.jangle.utils.ResultModel;
import xyz.jangle.utils.ResultModelList;

/**
 * ${tableRemarks} 控制层
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
@Controller
@RequestMapping("/${beanNameVar}Ctrl")
public class ${beanName}Ctrl {

	@Autowired
	private ${beanName}Service ${beanNameVar}Service;

	// 增
	@RequestMapping("/insert.ctrl")
	@ResponseBody
	ResultModel<${beanName}> insert(${beanName} record) {
		return ${beanNameVar}Service.insertOrUpdate(record);
	}

	// 删
	@RequestMapping("/deleteByPrimaryKey.ctrl")
	@ResponseBody
	ResultModel<${beanName}> deleteByPrimaryKey(${beanName} record) {
		return ${beanNameVar}Service.deleteByPrimaryKey(record);
	}

	// 改
	@RequestMapping("/updateByPrimaryKey.ctrl")
	@ResponseBody
	ResultModel<${beanName}> updateByPrimaryKey(${beanName} record) {
		return ${beanNameVar}Service.updateByPrimaryKey(record);
	}
	
	// 单查
	@RequestMapping("/selectByPrimaryKey.ctrl")
	@ResponseBody
	ResultModel<${beanName}> selectByPrimaryKey(${beanName} record) {
		return ${beanNameVar}Service.selectByPrimaryKey(record);
	}

	// 分查
	@RequestMapping("/selectPage.ctrl")
	@ResponseBody
	ResultModelList<${beanName}> selectPage(${beanName} record) {
		return ${beanNameVar}Service.selectPage(record);
	}

	// 全查
	@RequestMapping("/selectAll.ctrl")
	@ResponseBody
	ResultModelList<${beanName}> selectAll() {
		return ${beanNameVar}Service.selectAll();
	}
		
	// 批删
	@RequestMapping("/batchDeleteByPrimaryKey.ctrl")
	@ResponseBody
	ResultModel<${beanName}> batchDeleteByPrimaryKey(${beanName} record) {
		return ${beanNameVar}Service.batchDeleteByPrimaryKey(record);
	}

	// 批删Actually
	@RequestMapping("/batchDeleteByPrimaryKeyActually.ctrl")
	@ResponseBody
	ResultModel<${beanName}> batchDeleteByPrimaryKeyActually(${beanName} record) {
		return ${beanNameVar}Service.batchDeleteByPrimaryKeyActually(record);
	}

}
