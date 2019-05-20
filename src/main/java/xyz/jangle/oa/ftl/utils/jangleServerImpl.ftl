package xyz.jangle.demoname.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import xyz.jangle.demoname.dao.${beanName}Mapper;
import xyz.jangle.demoname.model.${beanName};
import xyz.jangle.demoname.service.${beanName}Service;
import xyz.jangle.utils.CME;
import xyz.jangle.utils.JConstant;
import xyz.jangle.utils.Jutils;
import xyz.jangle.utils.ResultModel;
import xyz.jangle.utils.ResultModelList;

/**
 * ${tableRemarks} 业务层
 * @author jangle E-mail: jangle@jangle.xyz
 * @version ${versionInfo}
 */
@Service
public class ${beanName}ServiceImpl extends BaseServiceImpl implements ${beanName}Service {

	@Autowired
	private ${beanName}Mapper ${beanNameVar}Mapper;
	
	
	@Override
	public ResultModel<${beanName}> insertOrUpdate(${beanName} record) {
		int i = 0;
		if (Jutils.isGreatThan0(record.getId()) || Jutils.isNotEmpty(record.getUuid())) {
			i = ${beanNameVar}Mapper.updateByPrimaryKey(record);
		} else {
			record.setUuid(UUID.randomUUID().toString().replaceAll("-", ""));
			i = ${beanNameVar}Mapper.insert(record);
		}
		if (i > 0) {
			return new ResultModel<${beanName}>(record);
		}
		return new ResultModel<${beanName}>(CME.error);
	}

	@Override
	public ResultModel<${beanName}> deleteByPrimaryKey(${beanName} record) {
		int i = ${beanNameVar}Mapper.deleteByPrimaryKey(record.getId());
		if (i > 0) {
			return new ResultModel<${beanName}>(CME.success);
		}
		logger.error(CME.error.getMessage());
		return new ResultModel<${beanName}>(CME.error);
	}
	
	@Override
	public ResultModel<${beanName}> updateByPrimaryKey(${beanName} record) {
		int i = ${beanNameVar}Mapper.updateByPrimaryKey(record);
		if (i > 0) {
			return new ResultModel<${beanName}>(CME.success);
		}
		return new ResultModel<${beanName}>(CME.error);
	}
	
	@Override
	public ResultModel<${beanName}> selectByPrimaryKey(${beanName} record) {
		return new ResultModel<${beanName}>(${beanNameVar}Mapper.selectByPrimaryKey(record.getId()));
	}
	
	@Override
	public ResultModelList<${beanName}> selectByParam(Map<String, Object> param) {
		List<${beanName}> list = ${beanNameVar}Mapper.selectByParam(param);
		return new ResultModelList<>(list);
	}


	@Override
	public ResultModelList<${beanName}> selectAll() {
		List<${beanName}> list = ${beanNameVar}Mapper.selectAll();
		return new ResultModelList<${beanName}>(list);
	}

	

	@Override
	public ResultModelList<${beanName}> selectPage(${beanName} record) {
		ResultModelList<${beanName}> resultModelList = new ResultModelList<${beanName}>(${beanNameVar}Mapper.selectPage(record));
		resultModelList.setCount(${beanNameVar}Mapper.selectPageCount(record));
		return resultModelList;
	}

	@Override
	public ResultModel<${beanName}> batchDeleteByPrimaryKey(${beanName} record) {
		if(Jutils.isEmpty(record.getIds())) {
			return new ResultModel<${beanName}>(CME.unFindIdsToDelete);
		}
		record.setIdsArray(record.getIds().split(JConstant.ywdh));
		${beanNameVar}Mapper.batchDeleteByPrimaryKey(record);
		return new ResultModel<${beanName}>(CME.success);
	}

}
