<%@page import="erp.common.DBCon"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
int emNum=0;
int diNum=0;
String emName="";
String emId="";
String emPwd="";
String credat="";
String diName="";
if("GET".equals(request.getMethod())){
	if(request.getParameter("em_num")!=null){
		emNum = Integer.parseInt(request.getParameter("em_num")); 
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			con = DBCon.getConnectin();
			String sql = "select em.*, di.di_num, di.di_name from employee em ,depart_info di where em.di_num=di.di_num and em.em_num=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1,emNum);
			rs = ps.executeQuery();
			if(rs.next()){
				diNum = rs.getInt("di_num");
				emName = rs.getString("em_name");
				emId = rs.getString("em_id");
				emPwd = rs.getString("em_pwd");
				credat = rs.getString("credat");
				diName = rs.getString("di_name");
			}
		}catch(Exception e){
			out.println(e);
		}finally{
			if(rs!=null){
				rs.close();
			}
			if(ps!=null){
				ps.close();
			}
			if(con!=null){
				con.close();
			}
		}
	}
}else if("POST".equals(request.getMethod())){
	if(request.getParameter("em_num")!=null){
		emNum = Integer.parseInt(request.getParameter("em_num")); 
		Connection con = null;
		PreparedStatement ps = null;
		try{
			con = DBCon.getConnectin();
			String sql = "update employee set em_name=?, em_id=?, em_pwd=?, di_num=? where em_num=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, request.getParameter("em_name"));
			ps.setString(2, request.getParameter("em_id"));
			ps.setString(3, request.getParameter("em_pwd"));
			ps.setInt(4,Integer.parseInt(request.getParameter("di_num")));
			ps.setInt(5,emNum);
			if(ps.executeUpdate()==1){
%>
<script>
	alert('수정완료');
	location.href = '/em-view.jsp?em_num=<%=emNum%>';
</script>
<%
			}
		}catch(Exception e){
			out.println(e);
		}finally{
			if(ps!=null){
				ps.close();
			}
			if(con!=null){
				con.close();
			}
		}
	}
}
%>
<form method="POST">
<table border="1">
	<tr>
		<td>사원번호</td>
		<td><input name="em_num" value="<%=emNum%>" readonly></td>
	</tr>
	<tr>
		<td>사원이름</td>
		<td><input name="em_name" value="<%=emName%>"></td>
	</tr>
	<tr>
		<td>아이디</td>
		<td><input name="em_id" value="<%=emId%>"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input name="em_pwd" value="<%=emPwd%>"></td>
	</tr>
	<tr>
		<td>부서명</td>
		<td><select name="di_num">
			<option value="<%=diNum%>"><%=diName%></option>
<%
if("GET".equals(request.getMethod())){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			con = DBCon.getConnectin();
			String sql = "select di_name,di_num from depart_info order by di_code";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				if(!diName.equals(rs.getString("di_name"))){
%>
	<option value="<%=rs.getInt("di_num")%>"><%=rs.getString("di_name") %></option>
<%
				}
			}
		}catch(Exception e){
			out.println(e);
		}finally{
			if(rs!=null){
				rs.close();
			}
			if(ps!=null){
				ps.close();
			}
			if(con!=null){
				con.close();
			}
		}
}
%>		
		</select></td>
	</tr>
	<tr>
		<td>입사일</td>
		<td><input name="credat" value="<%=credat%>" readonly></td>
	</tr>
</table>
<button>수정하기</button><button type="button" onclick="doCansle()">취소</button>
</form>
<script>
function doCansle(){
	history.back();
}
</script>
</body>
</html>