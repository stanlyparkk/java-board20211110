package com.sbs.example.board.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class JDBCInsertTest {

	public static void main(String[] args) {

		Connection conn = null; // DB 접속 객체
		PreparedStatement pstat = null; // SQL 구문을 실행하는 역할

		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // Mysql JDBC 드라이버 로딩
			String url = "jdbc:mysql://127.0.0.1:3306/text_board?useUnicode=true&characterEncoding=utf8&autoReconnect=true&serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true&zeroDateTimeNehavior=convertToNull";

			conn = DriverManager.getConnection(url, "root", ""); 
			
			String sql = "INSERT INTO article";
			sql += " SET regDate = NOW()";
			sql += ", updateDate = NOW()";
			sql += ", title = \"제목\"";
			sql += ", body = \"내용\"";
			
			pstat = conn.prepareStatement(sql);
			int affectedRows = pstat.executeUpdate();
			
			System.out.println("affectedRows: " + affectedRows);

		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			System.out.println("에러: " + e);
		} finally { // 예외 상황이든 아니든 무조건 마지막에 실행하는 finally
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close(); // 연결 종료
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			try {
				if (pstat != null && !pstat.isClosed()) {
					pstat.close(); // 연결 종료
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
