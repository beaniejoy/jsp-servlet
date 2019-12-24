<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@ page pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	//String name = request.getParameter("name"); => null

	// 왼쪽에 project explorer가 service되는 것이 아니라 따로 지정된 경로가 있다.
	String path = request.getRealPath("/upload/file");
	Calendar c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH) + 1;
	// File.separator(윈도우일 경우 /, Unix일 경우 \)
	// 해당 path를 DB에 저장했다가 나중에 href할때 사용가능
	path += File.separator + year + File.separator + month;
	
	// 디렉토리가 없으면 디렉토리부터 만들고
	File f = new File(path);
	if (!f.exists()) {
		f.mkdirs();
	}

	MultipartRequest multi = null;
	try {
		multi = new MultipartRequest(
				request, 
				path, //업로드할 디렉토리
				10 * 1024 * 1024, //업로드할 파일 크기
				"utf-8", //인코딩 타입
				//파일 이름이 중복되었을 때 파일명 끝에 1,2,3순으로 파일 이름을 변경해주는 클래스
				new DefaultFileRenamePolicy());
	} catch (Exception e) {
		e.printStackTrace();
	}
	String name = multi.getParameter("name");
	String fileName = multi.getFilesystemName("file");
	String uploadName = multi.getOriginalFileName("file");
	File f1 = new File(f, fileName);
	long fileSize = f1.length() / 1024;
%>

name : <%=name %><br>
<img src="/upload/file/<%=year%>/<%=month%>/<%=fileName %>" style="width:700px;hegith:500px"><br>
File System Name : <a href="/upload/file/<%=year%>/<%=month%>/<%=fileName %>"><%=fileName %></a>(<%=fileSize %>kb)<br>
File Origin Name : <%=uploadName %>

