<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${beanNameVar}-列表页面</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<jsp:include page="../../css/PageletCSS.jsp">
	<jsp:param value="table,daterang" name="p" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="../../build/css/backSystem.css" />
</head>
<body style="padding: 15px;">
	<div>
		<form class="form form-inline" id="searchForm">
			<input type="text" name="" placeholder="查询功能待开发"
				class="form-title-width form-control" /> 
				<input type="text" name=""
				placeholder="内容查询待开发" class="form-control" />
			<div class="form-group daterange">
		    	<input class="form-control base_cursor-pointer form-startEndDate" readonly="readonly" name="startEndDate" type="text" placeholder="起止时间"/>
			</div>
			<button type="button"
				class="btn searchButton glyphicon glyphicon-search"
				onclick="search()"></button>
			<div class="pull-right">
				<button type="button" class="btn btn-info draft-attr btn-sm"
					onclick="addFormInfo()">新增</button>
			</div>
		</form>
		<div class="base_margin-t-15 base_overflow-auto">
			<table id="dataTable" class="box base_tablewrap" data-toggle="table"
				data-locale="zh-CN" data-ajax="ajaxRequest"
				data-side-pagination="server" data-single-select="true"
				data-click-to-select="true" data-pagination="true"
				data-pagination-first-text="首页" data-pagination-pre-text="上一页"
				data-pagination-next-text="下一页" data-pagination-last-text="末页">
				<thead style="text-align: center;">
					<tr>
						<th  data-formatter="numberAsc" data-width="50">序号</th>
						<th data-field="id" data-formatter="titleFormatter">id</th>
						<!--<th data-field="demo...">...增加字段展示的地方</th> -->
						<th data-field="oaCreateTime" data-formatter="dateFormatter">创建日期</th>
						<th data-field="oaUpdateTime" data-formatter="datetimeFormatter">更新时间</th>
						<th data-field="id" data-formatter="opration" data-width="150" data-align='center'>操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<jsp:include page="../../js/PageletJS.jsp">
		<jsp:param value="daterang,table,oaList" name="p" />
	</jsp:include>
	<script type="text/javascript">
		var url = "../../${beanNameVar}Action!findPage.action"; //这里是添加分页查询的action地址（即列表页面的数据地址）
		//查看按钮格式化
		function opration(value, row) {
			return '<button class="btn btn-xs btn-info" onclick="openDetail('
					+ JSON.stringify(row).replace(/\"/g, "'")
					+ ')">查看</button>'
					+ '<button class="btn btn-xs btn-info base_margin-l-5" onclick="editDetail('
					+ JSON.stringify(row).replace(/\"/g, "'")
					+ ')">编辑</button>';
		};
		//标题格式化
		function titleFormatter(value,row){
			var value2 = titleLengthFormatter(value);
			return '<a href="#" title="'+value+'"  onclick="openDetail('+JSON.stringify(row).replace(/\"/g,"'")+')">'+value2+'</a>';
		};
		//查询
		function search() {
			$('#dataTable').bootstrapTable('selectPage', 1);
			var param = {
				silent : true
			};
			//$('#dataTable').bootstrapTable('refresh', param);
		};
		//新增按钮 打开新增数据的页面
		function addFormInfo() {
			window.location.href = "${beanNameVar}Edit.jsp"
		}
		//查看详情
		function openDetail(data) {
			window.location.href = "${beanNameVar}Open.jsp?id=" + data.id + addressPostfix;
		};
		//编辑详情
		function editDetail(data){
			window.location.href = "${beanNameVar}Edit.jsp?id=" + data.id + addressPostfix;
		}
	</script>
	<script type="text/javascript" src="../../build/js/tableAjax.js"></script>
	<script type="text/javascript">
		// List加载成功后的回调方法
	    function afterListSuccess(){
	    	// 这里添加加载成功后的回调逻辑。
	    }
	</script>
</body>
</html>