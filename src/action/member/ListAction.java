package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

public class ListAction extends AdminLoginAction {
	
	// ��ӹ�����, �θ�Ŭ������ �߻�޼��带 ������ �������̵��ؾ���
	@Override
	protected ActionForward adminExecute(HttpServletRequest request, HttpServletResponse response) {
		
		// MemberDao()�� list()�޼��带 ���ؼ� ������
		List<Member> list = new MemberDao().list();
		request.setAttribute("list", list);
		return new ActionForward();
	}
}

/*
 * MemberDao dao = new Member();
 * request.setAttribute("list", dao.list());
 */
