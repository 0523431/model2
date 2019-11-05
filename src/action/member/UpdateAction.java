package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

/* < �� �������� ��� >
 * 
 * 1. ��� �Ķ���� Member ��ü�� ����
 * 2. �Էµ� ��й�ȣ�� db�� ����� ��й�ȣ�� ����������, "��й�ȣ�� Ʋ�Ƚ��ϴ�" => udateForm.me������ �̵�
 * 3. 1���� ���� db�� �����ϱ� => int MemberDao.update(Member)
 *    ����� 0���� ũ�� �������� �޽��� ��� => info.me �̵�
 *    ����� 0�����̸�  �������� �޽��� ��� => main.me �̵�
 */

public class UpdateAction extends UserLoginAction { // ��ӹ��� ==> �ݵ�� �α����� �Ǿ��ϴ� ������
	
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		
		// 1��
		Member upmem = new Member();
		upmem.setId(request.getParameter("id"));
		upmem.setPass(request.getParameter("pass"));
		upmem.setName(request.getParameter("name"));
		upmem.setGender(Integer.parseInt(request.getParameter("gender")));
		upmem.setTel(request.getParameter("tel"));
		upmem.setEmail(request.getParameter("email"));
		upmem.setPicture(request.getParameter("picture"));
		
		Member dbmem = new MemberDao().selectOne(upmem.getId()); // id�� �־ ��
		// String login = (String)request.getSession().getAttribute("login"); ��ӹ��� ����
		
		String msg = null;
	    String url = null;
		System.out.println(dbmem);
		
		if(!login.equals("admin") && !upmem.getPass().equals(dbmem.getPass())) {
			msg = "��й�ȣ�� Ʋ�Ƚ��ϴ�";
			url = "updateForm.me?id="+upmem.getId();

		} else { // ��й�ȣ�� ������
			int result = new MemberDao().update(upmem);
			if(result >0) {
				msg = "�����Ϸ�";
				url = "info.me?id="+upmem.getId();
				
			} else {
				msg = "��������";
				url = "main.me";
				
			}
		}
		request.setAttribute("msg",msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");

	}
}
