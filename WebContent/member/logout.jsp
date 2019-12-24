<%@ page pageEncoding="utf-8"%>

<%
	/*
	HttpSession 객체를 종료하는 방법
	1. 브라우저를 종료했을 경우.
	2. 해당페이지의 시간이 세션 만료시간을 경과했을 경우
	3. invalidate() 메서드를 호출하는 경우
	
	세션이 만료되어버리면 기존의 session객체가 GC에 들어가고
	바뀐 jsessionid가 들어오면 새로운 session객체를 생성 
	*/
	
	// invalidate()는 client의 session객체 자체를 없애는 것이기에
	// 그 안에 담겨져있던 모든 정보들이 날라간다.
	// 장바구니만 없애고 싶을 때는 removeAttribute이용
	// session객체는 살리고 해당 attr 정보만 삭제
	// session.removeAttribute("member");
	
	session.invalidate();
	response.sendRedirect("/index.jsp");
	
%>