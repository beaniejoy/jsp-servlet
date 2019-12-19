<%@page import="kr.co.acorn.dto.DeptDto"%>
<%@ page import="kr.co.acorn.dao.DeptDao"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%
	String tempPage = request.getParameter("page");
	String tempNo = request.getParameter("no");
	if (tempPage == null || tempPage.length() == 0) {
		tempPage = "1";
	}
	if (tempNo == null || tempNo.length() == 0) {
		// No이 없으면 전페이지로 넘겨버린다.
		response.sendRedirect("list.jsp?page=" + tempPage);
		// redirect 할때 그 아래는 실행이 안되도록 return을 해서 끊는 것이 좋다.
		return;
	}
	// list의 현재페이지
	int cPage = 0;
	// 클릭한 해당 데이터
	int no = 0;
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	try{
		no = Integer.parseInt(tempNo);
	}catch(NumberFormatException e){
		// int로 바꾸는데 오류 발생시 이전페이지로 다시 돌려보냄
		response.sendRedirect("list.jsp?page="+cPage);
		// return으로 끊자.
		return;
	}
	
	DeptDao dao = DeptDao.getInstance();
	//여기까지 온 것은 제대로 된 형식의 no과 cpage가 온 것이긴 하지만 
	//no에 이상한 값이 들어갈 수도 있다.
	DeptDto dto = dao.select(no);
	//dto select하는데 이상한 no가 들어가면 dto는 null값을 반환
	//new로 안만들어지기 때문이다.
	if(dto == null){
		response.sendRedirect("list.jsp?page="+cPage);
		return;
	}
	String name = dto.getName();
	String loc = dto.getLoc();
%>
<!-- breadcrumb start -->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">Home</a></li>
		<li class="breadcrumb-item active" aria-current="page">DEPT</li>
	</ol>
</nav>
<!-- breadcrumb end -->
<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>부서상세보기</h3>
			<form name="f" method="post">
				<div class="form-group row">
					<label for="no" class="col-sm-2 col-form-label">부서번호</label>
					<div class="col-sm-10">
					<%-- readonly만 써도 작동하지만 속성값까지 써주는 것이 좋다. --%>
						<input type="number" class="form-control" id="no" name="no"
							readonly="readOnly" value="<%=no%>">
					</div>
				</div>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">부서이름</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name" name="name"
							value="<%=name%>">
					</div>
				</div>
				<div class="form-group row">
					<label for="loc" class="col-sm-2 col-form-label">부서위치</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="loc" name="loc"
							value="<%=loc%>">
					</div>
				</div>
				<%-- 수정할 때 페이지도 넘겨야 한다. --%>
				<input type="hidden" name="page" value="<%=cPage%>"/>
			</form>

			<div class="text-right">
				<a href="list.jsp?page=<%=cPage %>" class="btn btn-outline-secondary">목록</a>
				<button type="button" id="updateDept"
					class="btn btn-outline-success">수정</button>
				<button type="button" id="deleteDept" class="btn btn-outline-danger">삭제</button>
			</div>

		</div>
	</div>
</div>
<!-- main end -->
<%@ include file="../inc/footer.jsp"%>

<script>
	$(function() {
		$("#name").focus();
		$("#updateDept").click(function() {
			//자바스크립트 유효성 검사
			if ($("#no").val().length == 0) {
				alert("부서번호를 입력하세요.");
				$("#no").focus();
				return;
			}
			if ($("#name").val().length == 0) {
				alert("부서명을 입력하세요.");
				$("#name").focus();
				return;
			}
			if ($("#loc").val().length == 0) {
				alert("부서위치를 입력하세요.");
				$("#loc").focus();
				return;
			}

			//버튼에 따라 작동하는 게 다르면 action을 통해 나눠줄 수 있다.
			f.action = "update.jsp";
			//유효성 검사 마치고 form을 제출
			f.submit();
		});
		$("#deleteDept").click(function() {
			f.action = "delete.jsp";
			f.submit();
		})
	})
</script>


