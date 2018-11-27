package com.fline.zjoa.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.util.StringUtils;

import com.feixian.aip.platform.common.action.AbstractAction;
import com.feixian.tp.common.vo.Ordering;
import com.feixian.tp.common.vo.Pagination;
import com.fline.zjoa.access.model.${beanName};
import com.fline.zjoa.mgmt.service.${beanName}MgmtService;
import com.fline.zjoa.util.OaConstant;
import com.fline.zjoa.util.OaRM;
import com.opensymphony.xwork2.ModelDriven;

public class ${beanName}Action extends AbstractAction implements ModelDriven<${beanName}> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ${beanName} ${beanNameVar} = new ${beanName}();
	private int pageNum;
	private int pageSize;
	private String startEndDate;
	private String r;	//随机数
	private Map<String, Object> dataMap = new HashMap<String, Object>();
	private ${beanName}MgmtService ${beanNameVar}MgmtService;

	//分页查询
	public String findPage() {
		Pagination<${beanName}> page = new Pagination<${beanName}>();
		page.setCounted(true);
		page.setIndex(pageNum);
		page.setSize(pageSize);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("model", getModel());
		if (!StringUtils.isEmpty(this.getStartEndDate())) {
			String[] dateArr = this.getStartEndDate().split("-");
			SimpleDateFormat sdf = new SimpleDateFormat(OaConstant.datetimeFormatterFromList);
			try {
				Date startDate = sdf.parse(dateArr[0]+OaConstant.datetimeStartFormatterFromList);
				Date endDate = sdf.parse(dateArr[1]+OaConstant.datetimeEndFormatterFromList);
				param.put("startDate", startDate);
				param.put("endDate", endDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		Ordering order = new Ordering();
		order.addDesc("id");
		page = ${beanNameVar}MgmtService.findPagination(param, order, page);
		dataMap.put("result", page);
		dataMap.put("rm", OaRM.success);
		return SUCCESS;
	}

	//添加记录
	public String add${beanName}() {
		dataMap.put("result", ${beanNameVar}MgmtService.add${beanName}(getModel()));
		dataMap.put("rm", OaRM.success);
		return SUCCESS;
	}

	//删除记录
	public String remove${beanName}() {
		dataMap.put("result", ${beanNameVar}MgmtService.remove${beanName}(getModel()));
		dataMap.put("rm", OaRM.success);
		return SUCCESS;
	}

	//更新记录
	public String update${beanName}() {
		dataMap.put("result", ${beanNameVar}MgmtService.update${beanName}(getModel()));
		dataMap.put("rm", OaRM.success);
		return SUCCESS;
	}

	//查询记录
	public String findById() {
		dataMap.put("result", ${beanNameVar}MgmtService.findById(getModel()));
		dataMap.put("rm", OaRM.success);
		return SUCCESS;
	}

	@Override
	public ${beanName} getModel() {
		if (${beanNameVar} == null) {
			return new ${beanName}();
		}
		return ${beanNameVar};
	}

	public ${beanName} get${beanName}() {
		return ${beanNameVar};
	}

	public void set${beanName}(${beanName} ${beanNameVar}) {
		this.${beanNameVar} = ${beanNameVar};
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getStartEndDate() {
		return startEndDate;
	}

	public void setStartEndDate(String startEndDate) {
		this.startEndDate = startEndDate;
	}

	public void set${beanName}MgmtService(${beanName}MgmtService ${beanNameVar}MgmtService) {
		this.${beanNameVar}MgmtService = ${beanNameVar}MgmtService;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}

	public String getR() {
		return r;
	}

	public void setR(String r) {
		this.r = r;
	}

}
