package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;

/*
    1. �α׾ƿ� ������ ��� => "�α����ϼ���" �޽��� ���
	   - �ٸ� ������� ��й�ȣ ���� �Ұ�
	   - opener�������� loginForm.me�������� �̵�
		
	2. old_pass�� new_pass �Ķ���� �� ���� (new_pass�� con_pass�� ����)
	
	3. old_pass ��й�ȣ�� db�� ����� ��й�ȣ�� Ʋ����, ��й�ȣ ���� �޽��� ���
	   => passwordForm.me �������� �̵�
	   
	4. old_pass ��й�ȣ�� db�� ����� ��й�ȣ�� ������ ��й�ȣ ����
	   - opener�������� info.me�������� �̵�
	   - ���� ������ �ݱ�
*/

public class PwchangeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String login = (String)request.getSession().getAttribute("login");
				
		String old_pass = request.getParameter("old_pass"); // �Է��� ���
		String new_pass = request.getParameter("new_pass"); // ���� ���
		
		boolean opener = false;
		boolean closer = false;
		
		String msg = null;
		String url = null;
		
		if(login == null || login.trim().equals("")) { // �α׾ƿ� ����
			opener = true;
			closer = true;
			
			msg = "�α����ϼ���";
			url = "loginForm.me";

		} else { // �α��� ����
			
			if(!login.equals("admin")) {
				// ����Ǿ��ִ� db���� �ҷ�����
				MemberDao dao = new MemberDao();
				Member dbmem = dao.selectOne(login);

				if (!old_pass.equals(dbmem.getPass())) {
					opener = false;
					closer = false;
					msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�";
					url = "passwordForm.me?id=" + login;
				} else { // ��й�ȣ ��ġ
					int result = dao.updatepass(login, new_pass);
					if (result > 0) {
						opener = true;
						closer = true;
						msg = "��й�ȣ�� ���������� ����Ǿ����ϴ�";
						url = "info.me?id=" + login;
					}
				}
			} else {
				msg = "�����ڶ� ��й�ȣ�� �ٲ� �� �����ϴ�.";
				url = "list.me";
				opener = true;
				closer = true;
			}
		}
		// ��â�� �������� �Ӽ�����
		request.setAttribute("opener", opener);
		request.setAttribute("closer", closer);

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward();
	}
}
