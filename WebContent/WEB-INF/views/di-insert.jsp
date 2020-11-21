<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="di" class="erp.vo.DepartInfoVO"></jsp:useBean>
<jsp:useBean id="dib" class="erp.beans.DepartInfoBean"></jsp:useBean>
<jsp:setProperty property="*" name="di"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
out.println("울라울라");
if(di.getDiName()!=null){
	int cnt = dib.setDepartInfo(di);
	if(cnt==1){
		out.println("입력잘됨");
	}else{
		out.println("실패");
	}
	return;
}
%>
<form method="post">
	부서코드 : <input type="text" name="diCode"><br>
	부서명 : <input type="text" name="diName"><br>
	부서설명 : <input type="text" name="diEtc"><br>
	<button>부서등록</button>
</form>
</body>
</html>