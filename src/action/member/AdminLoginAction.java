package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * 1. �α׾ƿ� ���� : "�α����� �ʿ��մϴ�" => logingForm.me�� ������ �̵�
 * 2. �α��� ����
 * 		- �Ϲݻ���� : "�����ڸ� ������ �ŷ��Դϴ�" => main.me�� ������ �̵�
 */

// �����ڿ� �߻�Ŭ����
// �����ڸ� �� �� �ִ� ��ɿ��� �� Ŭ������ ��ӹ����� ������ Ȯ�� ������ �ʿ������
public abstract class AdminLoginAction implements Action {
	
	protected String login;
	protected String id;
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		id = request.getParameter("id");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg","�α����� �ʿ��մϴ�");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		} else {
			if(!login.equals("admin")) {
				request.setAttribute("msg","�����ڸ� ����� ������ ����Դϴ�");
				request.setAttribute("url", "main.me");
				return new ActionForward(false, "../alert.jsp");
			}
		}
		
		return adminExecute(request, response);
	}
	
	// �߻�޼���
	protected abstract ActionForward adminExecute(HttpServletRequest request, HttpServletResponse response);

}
