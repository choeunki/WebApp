<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>text login</title>
<!-- Bootstrap -->
<link href="bootstrap-3.3.4-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="bootstrap-3.3.4-dist/js/bootstrap.min.js"></script>
<!-- Google chart 사용 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

</head>
<style>
.start {
	padding: 10px 15px;
	text-align: center;
	color: inherit;
	margin-top: 100px;
	margin-bottom: 30px;
}

.login_box {
	padding: 10px 15px;
	text-align: center;
	border-radius: 6px;
	color: inherit;
	margin-bottom: 30px;
	background-color: #eee;
}

.button-submit {
	border: 1px solid #3079ed;
	color: #fff;
	text-shadow: 0 1px rgba(0, 0, 0, 0.1);
	background-color: #4d90fe;
	min-width: 46px;
	text-align: center;
	font-size: 14px;
	font-weight: 700;
	height: 36px;
	padding-top: 0px;
	padding-right: 8px;
	padding-bottom: 0px;
	padding-left: 8px;
	border-radius: 10px;
}

.circle-image {
	display: block;
	height: 96px;
	width: 96px;
	oveflow-x: hidden;
	oveflow-y: hidden;
	border-top-left-radius: 50%;
	border-top-right-radius: 50%;
	border-bottom-left-radius: 50%;
	border-bottom-right-radius: 50%;
	margin-left: auto;
	margin-right: auto;
	z-index: 100;
	margin-bottom: 10px;
	background-size: 96px;
	background-repeat: no-repeat;
	background-image:
		url(http://cache1.asset-cache.net/xc/495289236.jpg?v=2&c=IWSAsset&k=2&d=MNkv2nd0LYvnlHoZN2a_lUZkLRAgLYjJABL9b5Y6w8ynzgYZcwkWg4RPIvJWMq-R0);
	-webkit-transition: opacity 0.075s;
	-moz-transition: opacity 0.075s;
	-ms-transition: opacity 0.075s;
	-o-transition: opacity 0.075s;
	transition: opacity 0.075s
}
</style>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	int pass = 0;
	int npass = 0;

	ArrayList list = new ArrayList();
	ArrayList passlist = new ArrayList();
	Connection conn = null; // null로 초기화 한다.
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl"; // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "scott"; // 사용자 계정
		String pw = "0013"; // 사용자 계정의 패스워드

		Class.forName("oracle.jdbc.driver.OracleDriver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn = DriverManager.getConnection(url, id, pw); // DriverManager 객체로부터 Connection 객체를 얻어온다.

		/* 시험유형 조회 */
		String sql = "select * from qttype"; // sql 쿼리
		pstmt = conn.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
		rs = pstmt.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
		while (rs.next()) { // 결과를 한 행씩 돌아가면서 가져온다.
			list.add(rs.getString("type_index"));
		}
		/*합격률 조회*/
		sql = "select * from pass";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) { // 결과를 한 행씩 돌아가면서 가져온다.
			passlist.add(rs.getString("pass_type"));
		}

	} catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		out.println("member 테이블 호출에 실패했습니다.");
	} finally { // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException sqle) {
			} // Resultset 객체 해제
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			} // PreparedStatement 객체 해제
		if (conn != null)
			try {
				conn.close();
			} catch (SQLException sqle) {
			} // Connection 해제
	}
%>
<body>

	<%
		for (int i = 0; i < passlist.size(); i++) {
			if(passlist.get(i).equals("1")){
				pass++;
			}else{
				npass++;
			}
	
		}
	
	%>
	
	<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {

		var data = google.visualization.arrayToDataTable([
				[ 'Task', 'Hours per Day' ], [ '합격', <%=pass%> ], [ '불합격', <%=npass%> ] ]);

		var options = {
			title : 'My Daily Activities'
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));
		chart.draw(data, options);
	}
</script>
	<div id="piechart" style="width: 900px; height: 500px;"></div>
	<div class="container">

		<div class="start">
			<h1 class="hidden-big">Online Test</h1>
			&nbsp;
			<h4 class="hidden-small">성경 졸업고사 모의시험 프로그램입니다.</h4>
			<div class="login_box">
				<div class="circle-image"></div>
				<form action="first.jsp">
					<input name="email" type="text" placeholder="아이디 입력"><br>
					<br> <input name="password" type="password"
						placeholder="패스워드 입력"><br> <br> <select
						name="type">
						<option value="blank">응시할 시험 유형 선택</option>

						<%
							for (int i = 0; i < list.size(); i++) {
						%>
						<option value="<%=list.get(i)%>"><%=list.get(i)%></option>
						<%
							}
						%>
					</select> <br> <br> <input type="submit" class="button-submit"
						value="응시"> <input type="reset" class="button-submit"
						value="재설정">
				</form>
			</div>


		</div>
	</div>
	<%
		for (int i = 0; i < passlist.size(); i++) {
	%>
	<h1><%=passlist.get(i)%></h1>
	<%
		}
	%>




</body>
</html>