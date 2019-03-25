<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${beanNameVar}-编辑页面</title>
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
		&nbsp;${beanNameVar}编辑页面
		<div style="padding: 0px 1% 15px;" class="pull-right">
			<button class="btn btn-info btn-sm" id="submit"
				onclick="submitForm()">保存</button>
			<button class="btn btn-info draft-attr btn-sm" style="display: none;"
				onclick="delete${beanName}()" id="deleteButton">删除</button>
			<button class="btn btn-info draft-attr btn-sm" onclick="back()"
				id="backButton">关闭</button>
		</div>
	</div>
	<form onsubmit="return false;" class="form form-horizontal"
		id="approvalForm" name="approvalForm">
		<table class="base_viewTable">
			<!-- colspan不要随便写，要取每行td总数的最小公倍数，然后平分，然后可以通过设置width调节大小 -->
			<#list columnList as row>
			<#if row.beanProperty != "id" && row.beanProperty != "oaUuid" && row.beanProperty != "oaCreateTime" && row.beanProperty != "oaUpdateTime">
			<tr>
				<td colspan="3">${row.remarks}</td>
				<td colspan="21" class=""><input name="${row.beanProperty}"
					id="${row.beanProperty}" class="form-control" /></td>
			</tr>
			</#if>
			</#list>
			<tr>
				<td colspan="3">demo</td>
				<td colspan="3"><input name="" id="" class="form-control" /></td>
				<td colspan="3">demo</td>
				<td colspan="3"><input name="" id="" class="form-control" /></td>
				<td colspan="3">demo</td>
				<td colspan="3"><input name="" id="" class="form-control" /></td>
				<td colspan="3">demo</td>
				<td colspan="3"><input name="" id="" class="form-control" /></td>
			</tr>
			<tr>
				<td colspan="3">demo</td>
				<td colspan="9"><input name="" id="" class="form-control" /></td>
				<td colspan="3">demo</td>
				<td colspan="9"><input name="" id="" class="form-control" /></td>
			</tr>
			<tr>
				<td colspan="3">附件</td>
				<td colspan="21" id="attachments">
					<div class="form-group base_width-percent-100 base_margin-0">
						<input type="file" name="oaAttachmentFile" id="oaAttachmentFile"
							multiple="multiple" data-show-caption="true">
					</div>
				</td>
			</tr>
		</table>
		<!-- 隐藏域 -->
		<input type="hidden" id="id" name="id" />
		<input type="hidden" id="oaUuid" name="oaUuid" />
	</form>
	<jsp:include page="../../childPage/loading.html"></jsp:include>
	<jsp:include page="../../js/PageletJS.jsp">
		<jsp:param value="fileinput,bootstrapDialog,oaForm" name="p" />
	</jsp:include>
	<script type="text/javascript">
		var oaFileInputParam = {}; //附件上传的拓展参数
		var extArray = [ 'doc', 'docx' ]; //扩展名
		function submitForm() {
			/*if ($("#demoTitle").val() == null || $("#demoTitle").val() == "") {
				alert("请填写标题");
				return;
			}*/
			showMask();
			$.ajax({
				type : 'POST',
				url : '../../${beanNameVar}Action!add${beanName}.action',
				dataType : 'json',
				data : $("#approvalForm").serialize(),
				cache : false,
				error : function(request, textStatus, errorThrown) {
					jangleShowAjaxError(request, textStatus, errorThrown);
				},
				success : function(data) {
					// 					success(data);		//执行成功后的判断，操作成功则返回列表页。
					//存在附件时的判断start ************
					if (data == null || data.rm == null) {
						hideMask();
						alert("异常操作，请联系管理员");
						return;
					}
					if (data.rm != null && data.rm.code == 1) {
						var file = $("#oaAttachmentFile").val();
						if (file == null || file == "") {
							hideMask();
							success(data);
							return;
						}
						//存在附件则上传附件
						oaFileInputParam["attSourceId"] = data.result.id; //业务主键id
						oaFileInputParam["attSourceType"] = "${tableName}"; //填业务表名称
						uploadOaFileInput("oaAttachmentFile"); //上传附件
					} else {
						hideMask();
						alert(data.rm.msg);
						return;
					}
					//存在附件时的判断end ************
				}
			});
		}
		// TODO 其余的js函数写在这里

		// 删除
		function delete${beanName}() {
			Modal.confirm({
				msg : "是否删除？"
			}).on(function(e) {
				if (e) {
					showMask();
					$.ajax({
						url : "../../${beanNameVar}Action!remove${beanName}.action",
						dataType : "json",
						data : {
							"id" : id
						},
						cache : false,
						error : function(request, textStatus, errorThrown) {
							jangleShowAjaxError(request, textStatus, errorThrown);
						},
						success : function(data) {
							hideMask();
							success(data);
						}
					});
					hideMask();
				}
			});
		}

		// dom加载后逻辑
		$(function() {
			// 初始化附件上传组件
			initOaFileinput("oaAttachmentFile", "", oaFileInputParam, extArray);

			// TODO 其余的dom加载后逻辑写在这里

			if (!id) {
				return;
			}
			$("#deleteButton").show();
			// 加载数据业务数据
			$.ajax({
				url : "../../${beanNameVar}Action!findById.action",
				dataType : "json",
				data : {
					"id" : id
				},
				cache : false,
				error : function(request, textStatus, errorThrown) {
					jangleShowAjaxError(request, textStatus, errorThrown);
				},
				success : function(data) {
					findByIdSuccess(data);
				}
			});
			// 加载附件
			findAttachmentsBySource("${tableName}");
		});
	</script>
</body>
</html>