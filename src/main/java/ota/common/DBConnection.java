package ota.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	private static final String url = "jdbc:mysql://localhost:3306/ota";
	private static final String user = "otaadmin";
	private static final String password = "1234";

	public static Connection getConnection() {

		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	public static void close(Statement stmt) {
		if (stmt != null) {
			try {
				if (!stmt.isClosed())
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				stmt = null;
			}
		}
	}

	public static void close(ResultSet rset) {
		if (rset != null) {
			try {
				if (!rset.isClosed())
					rset.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				rset = null;
			}
		}
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				if (!conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}

	public static void commit(Connection conn) {
		if (conn != null) {
			try {
				if (!conn.isClosed())
					conn.commit();
				;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}

	public static void rollback(Connection conn) {
		if (conn != null) {
			try {
				if (!conn.isClosed())
					conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				conn = null;
			}
		}
	}
}
