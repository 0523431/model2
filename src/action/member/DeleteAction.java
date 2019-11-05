package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 *  ������ ��ο� ���� �Ķ���Ͱ� 2���� ��
	
	1. �α׾ƿ� ���� : "�α����ϼ���" �޽�ġ ��� => login.jsp ������ �̵�

	2. �α��� ����
	   - �����ڰ� �ƴϰ�, id�� login�� �ٸ� ���
	     "���θ� Ż�� �����մϴ�" �޼��� ��� => main.jsp �������� �̵�
	------------------------------------------------------------ UserLoginAction���� 
	   <id�� �������� ���>
	     "�����ڴ� Ż�� �Ұ����մϴ�" �޼��� ��� => list.me ������ �̵�
	   --------------------------------------------------------- ��ȿ�� ����
	   <Ż�� ����>
	   - �Էµ� ��й�ȣ�� db�� ��й�ȣ�� ����
	     => �����ڰ� �ƴϸ鼭 ��й�ȣ ����ġ
	   - �Ϲ� �����  :(1) ���̵�, ��й�ȣ ������ �Ķ���ͷ� ����
	   			  (2) ��й�ȣ ����ġ, �Էµ� ��й�ȣ�� db�� ��й�ȣ�� ����
	   			      "��й�ȣ�� Ʋ���ϴ�.=>�޽��� ��� deleteForm ������ �̵�
	   - ������ : (1) id ������ �Ķ���ͷ� ����

	   <������ �α���, �Ǵ� ��й�ȣ�� ��ġ�ϴ� ��� db���� ȸ������ �����ϱ�>
	   - ���� ���� : �Ϲݻ���� : �α׾ƿ� ��, "Ż��" �޼������ => loginForm.jsp�� ������ �̵�
	   		            ������ : "Ż��" �޼������ => list.jsp�� ������ �̵�
	   - ���� ���� : �Ϲݻ����, "��������" �޽��� ��� => info.me ������ �̵�
	     		   ������ : "�������� " �޽��� ��� => list.me ������ �̵�

 */
public class DeleteAction extends UserLoginAction { // �α��ο���, admin�α��� ���� �̸� Ȯ������

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		
		String pass = request.getParameter("pass");
		
		String msg = null;
		String url = null;
		
		// �������� ���
		if(id.equals("admin")) {
			msg = "�����ڴ� Ż�� �Ұ����մϴ�";
			url = "list.me";
		} else { // �����ڰ� �ƴѰ��
			Member dbmem = new MemberDao().selectOne(id);
			System.out.println(dbmem);
			
			// �������̰ų� ��й�ȣ�� �°ų�
			if(login.equals("admin") || pass.equals(dbmem.getPass())) {
				int result = new MemberDao().delete(id);
				if (result > 0) { // ���� ����
					if (login.equals("admin")) {
						msg = id + "����Ż�� ���� ��Ŵ";
						url = "list.me";
					} else {
						msg = id + "���� ������ Ż�� �����Ͽ����ϴ�";
						url = "loginForm.me";
						request.getSession().invalidate(); // �α��� ���� ����
					}
				} else {
					msg = id + "���� Ż�� �������� ������ �߻��߽��ϴ�";
					if (login.equals("admin")) {
						url = "list.me";
					} else
						url = "info.jsp?id=" + id;
				}
								
			} else {
				msg = "��й�ȣ�� Ʋ���ϴ�";
				url = "deleteForm.jsp?id="+id;
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url",url);
		return new ActionForward(false, "../alert.jsp");
	}

}
