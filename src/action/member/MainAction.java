package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;

/*
 * �Ź� �α��� ���θ� Ȯ���ϴ� ������
 * UserLoginAction <<<<<<<<<<<<�� ��ӹ������ν� �ذ�
 * 
 * �� ���������� �ƹ� ����� ������,
 * �θ�Ŭ������ �ִ� ����� 
 */

public class MainAction extends UserLoginAction {
	
	// �α����� �Ǿ��ִ� ��쿡�� doExecute�޼��带 ��������
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		return new ActionForward();
	}

}
