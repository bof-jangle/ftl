<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${beanNameVar}-查看页面</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<jsp:include page="../../css/PageletCSS.jsp">
	<jsp:param value="fileinput,bootstrapDialog,oaForm" name="p" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="../../build/css/backSystem.css" />
</head>
<body class="base_padding-15">
	<div class="sendDocumentTitle">
		&nbsp;${beanNameVar}-查看页面
		<div style="padding: 0px 1% 15px;" class="pull-right">
			<button class="btn btn-info draft-attr btn-sm" onclick="back()"
				id="backButton">关闭</button>
		</div>
	</div>
	<form onsubmit="return false;" class="form form-horizontal"
		id="approvalForm" name="approvalForm">
		<table class="base_viewTable oaTable">
			<!-- colspan不要随便写，要取每行td总数的最小公倍数，然后平分，然后可以通过设置width调节大小 -->
			<#list columnList as row>
			<#if row.beanProperty != "id" && row.beanProperty != "oaUuid" && row.beanProperty != "oaCreateTime" && row.beanProperty != "oaUpdateTime">
			<tr>
				<td colspan="3" width="10%">${row.remarks}</td>
				<td colspan="21" id="${row.beanProperty}"></td>
			</tr>
			</#if>
			</#list>
			<tr>
				<td colspan="3">附件</td>
				<td colspan="21" id="attachments">
					
				</td>
			</tr>
		</table>
	</form>
	<jsp:include page="../../js/PageletJS.jsp">
		<jsp:param value="fileinput,bootstrapDialog,oaForm"
			name="p" />
	</jsp:include>
	<script type="text/javascript">
		$('#approvalForm').find('input').attr('readonly',true);			//只读
		$('#approvalForm').find('input,select').attr('disabled',true);	//禁用
		
		// 加载数据业务数据
		$.ajax({
			url:"../../${beanNameVar}Action!findById.action",
			dataType:"json",
			data:{"id":id},
			cache:false,
			error : function(request, textStatus, errorThrown) {
				jangleShowAjaxError(request, textStatus, errorThrown);
			},
			success :function(data){
				findByIdSuccess(data);
			}
		});
		// 加载附件
		findAttachmentsBySource("${tableName}",false);
	</script>
</body>
</html>