<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
body{
	margin:0;
	padding:0;
	font-family: sans-serif;
	background-color: #092322;
}
.box{
	color: white;
	width: 500px;
	padding: 40px;
	position: absolute;
	top: 50%;
	left: 50%; 
	transform: translate(-50%,-50%);
	background: #191919;
	text-align: center;
}
.box a{
	color: white;
}
.box h1{
	color: white;
	text-transform: uppercase;
	font-weight: 500; 
}
.box p{
	font-size: 1.2rem;
	margin:10px;
	color: white; 
	text-transform: uppercase;
}
.box input[type="text"], .box input[type="submit"],  .box input[type="button"] , .box input[type="password"], .box select, table{
	boarder:0;
	background: none;
	display: block;
	margin: 10px auto;
	text-align: left;
	border: 2px solid #3498db;
	padding: 14px 10px;
	width: 420px;
	outline: none;
	border-radius:12px;
	transition :0.24s;
	font-size: 1rem;
	color: white;
}
.box option {
	color : black;
}
.box input[type="submit"], .box input[type="button"]{
	width: 150px;
	text-align: center;
	font-size: 1.2rem;
	text-transform: uppercase; 
}
.box input[type="submit"]:hover, .box input[type="button"]:hover{
	border: 2px solid #2ecc71;
	background-color: #2ecc71;
}
.box input[type="text"]:focus{
	border-color: #2ecc71; 
}
</style>