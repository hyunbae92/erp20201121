<%@page import="erp.common.DBCon"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
*{
	font-family: sans-serif;
	padding: 0;
	margin: 0;
	position: relative;
}
body{
	width : 100%;
	position: absolute;
	align-content: center;
}
</style>
</head>
<body>
<h1>JSP Test</h1>
<form>
부서명 : <input type="text" name="di_name"><br>
부서설명 : <input type="text" name=di_etc><button>검색</button>
</form>
<table border="1">
	<tr>
		<th>부서번호</th>
		<th>부서코드</th>
		<th>부서명</th>
		<th>기타</th>
		<th>부서인원</th>
	</tr>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try{
	con = DBCon.getConnectin();
	String sql = "select di.*,(select count(*) from employee emp where emp.DI_NUM=di.di_num) as cnt from depart_info di where 1=1 ";
	if(request.getParameter("di_name")!=null && !"".equals(request.getParameter("di_name"))){
		sql += " and di_name like '%' || ? || '%'";
	}
	if(request.getParameter("di_etc")!=null && !"".equals(request.getParameter("di_etc"))){
		sql += " and di_etc like '%' || ? || '%'";
	}
	sql += "order by di_code";
	ps = con.prepareStatement(sql); 
	if(request.getParameter("di_name")!=null && !"".equals(request.getParameter("di_name"))){
		ps.setString(1, request.getParameter("di_name"));
	}
	if(request.getParameter("di_etc")!=null && !"".equals(request.getParameter("di_etc"))){
		if(request.getParameter("di_name")!=null && !"".equals(request.getParameter("di_name"))){
			ps.setString(2, request.getParameter("di_etc"));
		}else{
			ps.setString(1, request.getParameter("di_etc"));
		}
	}
	rs = ps.executeQuery();
	while(rs.next()){
%>
	<tr>
		<td><%=rs.getString("di_num")%></td>
		<td><%=rs.getString("di_code")%></td>
		<td><a href="/di-view.jsp?di_num=<%=rs.getString("di_num")%>"><%=rs.getString("di_name")%></a></td>
		<td><%=rs.getString("di_etc")%></td>	
		<td><a href="/em-list.jsp?di_num=<%=rs.getString("di_num")%>"><%=rs.getString("cnt")%></a></td>	
	</tr>
<%
	}
	}catch(Exception e){
		e.printStackTrace();
		out.print(e);
	}finally{
		if(con!=null){
			con.close();
		}
		if(ps!=null){
			ps.close();
		}
		if(rs!=null){
			rs.close();
		}
	}
%>
</table>
<a href="/di-insert.jsp"><input type="button" value="부서등록"></a>
</body>
</html>