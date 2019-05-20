/*!
 * ${tableRemarks} 专用JS
 * 
 */

// 校验的渲染
$("#jangleEditForm").bootstrapValidator({
	message : 'This value is not valid',
	feedbackIcons : {
		valid : 'glyphicon glyphicon-ok',
		invalid : 'glyphicon glyphicon-remove',
		validating : 'glyphicon glyphicon-refresh'
	},
	fields : {
		<#list columnList as row>
		<#if row.beanProperty != "id" && row.beanProperty != "uuid" && row.beanProperty != "createTime" && row.beanProperty != "updateTime" && row.beanProperty != "status" >
		${row.beanProperty} : {
			validators : {
				notEmpty : {
					message : "请输入${row.remarks}"
				}
			}
		}<#if row_has_next>,</#if>
		</#if>
		</#list>
	}
});
