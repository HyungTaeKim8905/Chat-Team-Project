package DTO;

import java.sql.ResultSet;

import DB.DBManager;

public class UserDTO extends DBManager {
	
	//***************************���̵� �� ��й�ȣ ã�� �� ��й�ȣ �缳�� �޼���************************************************************
	
		// ���̵� ã�� �޼��� 
		public boolean FindID(String phone)	{
			try {
				String sql = "select id from user where phone = ?";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, phone);
				m_ResultSet = m_SelectStatment.executeQuery();
				return true;
			}
			catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return false;
			}
		}
		
		// ��й�ȣ ã�� �޼���
		public boolean FindPassWord(String id)	{
			try {
				String sql = "select password from user where id = ?";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, id);
				m_ResultSet = m_SelectStatment.executeQuery();
				return true;
			}
			catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return false;
			}
		}
		
	//*************************************************************************************************************************************

	//***************************ȸ������ �޼���******************************************************************************************************
		
		public int Join(String id, String password, String name, String birth, String gender, String email, String address, String phone)	{
			try {
				// ȸ������������(join.jsp)���� �Ķ���ͷ� ���۵� �����͵��� user���̺��� ���ο� ���ڵ�� �����ϴ� �κ��̴�.
				String sql = "insert into user (id, password, name, birth, gender, email, address, phone) values (?,?,?,?,?,?,?,?)";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, id);
				m_SelectStatment.setString(2, password);
				m_SelectStatment.setString(3, name);
				m_SelectStatment.setString(4, birth);
				m_SelectStatment.setString(5, gender);
				m_SelectStatment.setString(6, email);
				m_SelectStatment.setString(7, address);
				m_SelectStatment.setString(8, phone);
				m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
				// m_SelectStatment �� �ݴ´�.
				m_SelectStatment.close();
				DBClose(); 
				return 1;		//ȸ������ �����ϸ� 1 ��ȯ
			}
			catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return 0;		//�����ϸ� 0 ��ȯ
			}
		}
		
		//***********************************************************************************************************************************
		
		//********************************// �α��� ó�� �޼���**********************************************************************************
		
		//DB���� ������ ��й�ȣ�� Ŭ���̾�Ʈ�� �Է��� ��й�ȣ�� ���ϴ� �κ�
		public int LoginCheck(String id, String password)	{
			try {
				String sql = "select * from user where id = ?";// Ŭ���̾�Ʈ�� �Է��� ���̵� ������ �ִ� ȸ���� ������ ��ȸ�ϴ� sql��
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, id); 
				m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
				if(ResultNext())	{
					if(password.equals(m_ResultSet.getString("password")))	{//getString�Լ��� �ش� ������ �����ִ� �����͸� String������ �޾ƿ´� ���̴�.
						return 1;											 //������� mResultSet.getString(2)�� �ϰԵǸ� 2��° �����ִ� �����͸� �������� �ȴ�. �� �÷��� name �� num�� �ִٰ� �����ϸ�
					}				//�α��� ����								// ��--------consol------------------��
					else	{												// �ӱ�����      111000				��
						return 0;	//��й�ȣ Ʋ��							    // ��--------------------------------��
					}				 	 	 
				}											 	     	
					else {
						return -1;	// �������� �ʴ� ���̵�
					}
				}
				catch(Exception e) {
					System.out.println("ERROR:" + e.getMessage());
					return -2;		//db ����
				}
			}
		
		//*************************************************************************************************************************************
		
		//****************************************���̵� �ߺ�Ȯ�� �˻� �޼���************************************************************************
		
		public int CheckID(String id)	{
			try {
				String sql ="select * from user where id=?";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, id); 
				m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
				if(ResultNext())	{	//id�� ������ 1 
					m_ResultSet.close();
					m_SelectStatment.close();
					m_Connection.close();
					return 1;
				}
				else	{				//id�� ������ 0
					m_ResultSet.close();
					m_SelectStatment.close();
					m_Connection.close();
					return 0;
				}
				
			} catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return -2;		//db ����
			}
		}
		
		//***************************������ ���������� Ŭ���̾�Ʈ ��� �����ִ� �޼���**************************************************
		
		public boolean ClientList()	{
			try {
				String sql = "select * from user";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_ResultSet = m_SelectStatment.executeQuery(); //����� ����
				return true;
			} catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return false;		//db ����
			}
		}
		//***********************�����ڰ� Ŭ���̾�Ʈ ���� �����ϴ� �޼���********************************************************************************
		
		public boolean MemberDelete(String deleteid)	{
			try {
				String sql = "delete from user where id=?";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, deleteid);
				m_SelectStatment.executeUpdate(); // ���������ϸ� ���� ����� java.sql.ResultSet������ �����Ѵ�.
				// m_SelectStatment �� �ݴ´�.
				m_SelectStatment.close();
				return true;
			} catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return false;		//db ����
			}
		}
		//********************ȸ�� ������ �����ִ� �޼���(�����ڸ� �� ������)****************************************************************************************************
		
		public boolean MemberInfo(String infoid)	{
			try {//user ���̺��� ������ Ȯ���� ���̵� ������ �ִ� ȸ�� ������ user ���̺��� ��ȸ*********
				String sql = "select * from user where id=?";
				DBOpen();
				m_SelectStatment = m_Connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				m_SelectStatment.setString(1, infoid);
				m_ResultSet = m_SelectStatment.executeQuery();
				return true;
			} catch(Exception e) {
				System.out.println("ERROR:" + e.getMessage());
				return false;		//db ����
			}
		}
		//*********************************************************************************************************************
		
		//**********************÷�������� �ٿ�ε� �� ������ �ٿ�ε� Ƚ���� ���������ִ� �޼���********************************************	
		
		public void downloadcount(String filedownload)	{
			String sql = "update board set downloadcount = downloadcount + 1 where filerealname='" + filedownload +"'";
			try {
				DBOpen();
				Excute(sql);
				DBClose();
			}catch(Exception e) {
				System.out.println("÷������ ī��Ʈ�� �����ϴµ� �־� ����");
				System.out.println("ERROR:" + e.getMessage());
			}
		}
		
		//*******************************************************************************************************************

		
		//*************************************��� ��� ���ִ� �޼���*****************************************************************
		
		public boolean commentok(String no, String id, String note)	{
			String sql = "insert into comment (no, id, Reply, Rdate) values ('"+ no +"', '"+ id +"', '"+ note +"', now())";
			try	{				// �ۼ���, ����, �ۼ���
				DBOpen();	
				Excute(sql);
				DBClose();
				return true;	//����� ����ϸ� true ��ȯ
			} catch(Exception e)	{
				System.out.println("ERROR : " + e.getMessage());	//�����ϸ� false 
				return false;
			}
		}
		
		//*******************************************************************************************************************
		
		
}
