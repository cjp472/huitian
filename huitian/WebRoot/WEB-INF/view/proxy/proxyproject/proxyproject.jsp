<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title>项目列表</title>
		<jsp:include page="../basecss.jsp" />
		<style type="text/css" >
			.leftalign { text-align: left; }
		</style>
		<script src="/js/js/jquery-2.1.1.min.js"></script>
	</head>
	<body>
		<div id="wrapper" style="background: #2f4050;min-width:1100px">
			<%@ include file="/common/left-nav.jsp"%>
			<div class="gray-bg dashbard-1" id="page-wrapper">
				<div class="row border-bottom">
					<nav class="navbar navbar-static-top fixtop" role="navigation">
					  <%@ include file="/common/top-index.jsp"%>
					</nav>
				</div>
			
				<div class="margin-nav" style="width:100%;">	
					<form action="/proxy/list" method="post" id="searchForm" >
						<div  class="col-lg-12">
							<div class="ibox float-e-margins">
				    			<div class="ibox-title" >
									<h5>
									   <img alt="" src="/images/img/currtposition.png" width="16" style="margin-top:-1px">&nbsp;&nbsp;
									   <a href="javascript:window.parent.location='/account'">${_res.get("admin.common.mainPage") }</a> 
									    &gt;&nbsp;&nbsp;渠道管理&nbsp;&gt;&nbsp;项目列表
								    </h5>
				          			<div style="clear:both"></div>
								</div>
								<div class="ibox-content" style="padding-top: 0px;" >
									<div class="flt m-t-sm m-l">
										<label>姓名</label>
										<input type="text" value="${paramMap['_query.personname'] }" name="_query.personname" class="input-s-sm" />
									</div>
									<div class="flt m-t-sm m-l" >
										<label>所在地</label>
										<input type="text" value="${paramMap['_query.location'] }" name="_query.location" class="input-s-sm" />
									</div>
									
									<div class="flt m-t-sm m-l" >
										<label>创建日期</label>
										<input type="text" readonly="readonly"  value="${paramMap['_query.startdate'] }" id="startdate" 
											 name="_query.startdate" class="input-s-sm znzhong " /> - 
										<input type="text" readonly="readonly"  value="${paramMap['_query.enddate'] }" id="enddate" 
											 name="_query.enddate" class="input-s-sm znzhong " />
									</div>
										 
									<div class="flt m-t-sm m-l" >
										<label>创建人</label>
										<input type="text" value="${paramMap['_query.createname'] }" name="_query.createname" class="input-s-sm" />
									</div>
									
									<div class="flt m-t-sm m-l" >
										<label>服务专员</label>
										<input type="text" value="${paramMap['_query.commissioner'] }" name="_query.commissioner" class="input-s-sm" />
									</div>
									
									<div class="flt m-t-sm m-l" >
										<label>代理类型</label>
										<select class="chosen-select input-s-sm" name="_query.type" >
											<option value="" >全部</option>
											<option value="0" ${paramMap['_query.type'] eq '0' ? 'selected="selected"' : '' } >个人</option>
											<option value="1" ${paramMap['_query.type'] eq '1' ? 'selected="selected"' : '' } >机构</option>
										</select>
									</div>
									<input type="hidden" name="_query.searchType" value="${paramMap['_query.searchType'] }" />
									
									<div class="flt m-t-sm m-l" >
										<input type="button" onclick="research()" value="${_res.get('admin.common.select')}" 
											class="btn btn-outline btn-primary">
										<c:if test="${operator_session.qx_proxynewProxy }">
											<a href="/proxy/newProxy" class="btn btn-outline btn-success">${_res.get('teacher.group.add')}</a>
											<input type="button" id="batchImport" class="btn btn-outline btn-warning" 
					         					value='导入' onclick="batchimport()" />
										</c:if>
										<a onclick="exportProxy()" class="btn btn-outline btn-info">导出</a>
									</div>
									<div style="clear:both;" ></div> 
								</div>
							</div>
						</div>
				
						<div class="col-lg-12" style="min-width:680px">
							<div class="ibox float-e-margins">
								<div class="ibox-title">
									<h5>项目列表</h5>
								</div>
								<div class="ibox-content">
									<table class="table table-hover table-bordered" width="100%">
										<thead>
											<tr>
												<th  >序号</th>
												<th  >类型</th>
												<th  >名称</th>
												<th  >机构名称</th>
												<th  >联系电话</th>
												<th  >所在地</th>
												<th  >通讯地址</th>
												<th  >创建日期</th>
												<th  >创建人</th>
												<th  >服务专员</th>
												<th  >状态</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${splitPage.page.list }" var="proxy" varStatus="index" >
												<tr>
													<td>${index.count }</td>
													<td>${proxy.type eq '0' ? '个人' : '机构' } </td>
													<td>${proxy.personname } </td>
													<td>${proxy.companyname } </td>
													<td>${proxy.type eq '0' ? proxy.tel : proxy.companytel } </td>
													<td class="leftalign" >${proxy.location } </td>
													<td class="leftalign" >${proxy.address } </td>
													<td><fmt:formatDate value="${proxy.createdate }" pattern="yyyy-MM-dd" /> </td>
													<td>${proxy.createname } </td>
													<td>${proxy.commissioner }</td>
													<td>${proxy.state eq '0' ? '正常' : '取消' } </td>
													<td>
														<c:if test="${ empty proxy.sysaccountid && proxy.state eq '0' }" >
															<a class="btn btn-xs btn-warning" onclick="openAccount( ${proxy.id } )" >开通账号</a>
														</c:if>
														<c:if test="${!empty proxy.sysaccountid }">
															<a class="btn btn-xs btn-warning" onclick="viewAccount( ${proxy.id } )" >账号</a>
														</c:if>
														<a class="btn btn-xs btn-info" href="/proxy/viewProxy/${proxy.id }" >查看</a>
														<a class="btn btn-xs btn-success" href="/proxy/editProxy/${proxy.id }" >编辑</a>
														<a class="btn btn-xs btn-primary" href="javascript:void(0)" >项目</a>
														<a class="btn btn-xs btn-danger" href="/proxy/contract/proxyContract/${proxy.id }" >合同</a>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>    
									<div id="splitPageDiv">
										<jsp:include page="/common/splitPage.jsp" />
									</div>
								</div>
							</div>
						</div>
						<div style="clear:both;"></div>
					</form>
				</div>
			</div>	  
		</div>  
		
		<jsp:include page="../basejs.jsp" />
		<script type="text/javascript">
			
			$( document ).ready( function() {
				var startDate = {
					elem : "#startdate",
					format : 'YYYY-MM-DD',
					istime : false,
					istoday : true,
					choose : function( date ) {
						endDate.min = date;
					}
				}
				var endDate = {
					elem : "#enddate",
					format : 'YYYY-MM-DD',
					istime : false,
					istoday : true,
					choose : function( date ) {
						startDate.max = date;
					}
				}
				laydate( startDate );
				laydate( endDate );
				
			} );
			
	
		</script>
	
	</body>
</html>