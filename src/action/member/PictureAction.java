package action.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.Action;
import action.ActionForward;
/*
1. ���Ͼ��ε�			: java ���� =========================> �� ��ɸ� ���⼭ �ϴ°ž�
2. opener ȭ�鿡 ���	: javaScript ����
3. ����ȭ�� close()		: javaScript ����
*/

public class PictureAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// application ===> request.getServletContext()
		String path = request.getServletContext().getRealPath("") + "model2/member/picture";
		String fname = null;

		try {
			File f = new File(path);
			
			if (!f.exists()) { // �ش� ��ġ�� ������
				f.mkdirs(); // ������ �����
			}
			
			int size = 10 * 1024 * 1024; // 10M ����

			MultipartRequest multi = new MultipartRequest(request, path, size, "euc-kr");
			fname = multi.getFilesystemName("picture");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("fname", fname); // �� �Ӽ����� picture.jsp�� ����
		return new ActionForward();
	}
}
