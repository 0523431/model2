package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.MemberDao;

public class FindAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		
		if(id == null) { // ���̵� ������ ���� = ���̵� ã��
			return idSerch(request, tel, email);
		} else {
			return pwSerch(request, id, tel, email);
		}
	}
		
	private ActionForward pwSerch(HttpServletRequest request, String id, String tel, String email) {
		MemberDao dao = new MemberDao();
		String fpw = dao.findPass(id, email, tel);
		
		if(fpw==null || fpw.equals("")) {
			
			request.setAttribute("msg","�ش� ������ �����ϴ�");
			request.setAttribute("url", "pwForm.me");
			return new ActionForward(false, "../alert.jsp");
		} else {
			request.setAttribute("pass", fpw.substring(2, fpw.length()));
			return new ActionForward();
		}

	}

	private ActionForward idSerch(HttpServletRequest request, String tel, String email) {
		MemberDao dao = new MemberDao();
		String fid = dao.findId(email, tel);
		
		String msg = null;
		String url = null;

		if(fid==null || fid.equals("")) { // �ش� ������ ���̵� ����
			msg = "�ش� ������ �����ϴ�";
			url = "idForm.me";

			request.setAttribute("msg",msg);
			request.setAttribute("url", url);
			return new ActionForward(false, "../alert.jsp");
		} else { // ������ �´� ���̵� �־�
			request.setAttribute("id", fid.substring(0, fid.length()-2) +"**");
			return new ActionForward();
		}
	
	}
	
}
