package action.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.BoardDao;

public class BoardAllAction {
	// db�����
	private BoardDao dao = new BoardDao();
	
	public ActionForward hello(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("hello", "Hello, World");
		return new ActionForward();
	}
	
	/* <�� ��>
	 * 1. multipart/form-data Ÿ���� �����̹Ƿ�, MultipartRequest ��ü ����
	 * 2. �Ķ���� ���� model.Board ��ü�� ����
	 * 3. �Խù� ��ȣ num�� ���� ��ϵ� num�� �ִ밪�� ��ȸ �� +1
	   => ��ϵ� �Խù��� ��ȣ : �ִ밪 +1
	   => db���� maxnum�� ���ؼ� 1�� ���� ������ num�� ����
	   
	 * 4. board����(�Էµ� ����)�� db�� ����ϱ�
	   - ��ϼ��� : �޽��� ��� => list.jsp ������ �̵�
	   - ��Ͻ��� : �޽��� ��� => writeForm.jsp ������ �̵�
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		// msg, url default��
		String msg = "�Խù� ��� ����";
		String url = "writeForm.do";
		
		// 1��
		String ulpath = request.getServletContext().getRealPath("/") + "model2/board/file/";
		try {
			File f = new File(ulpath);
			if(!f.exists()) { // �������� ������ ������ �����
				f.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(request, ulpath, 10*1024*1024,"euc-kr");
			
			// 2��
			Board b = new Board();
			b.setName(multi.getParameter("name"));
			b.setPass(multi.getParameter("pass"));
			b.setTitle(multi.getParameter("title"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			
			// 3��
			int num = dao.maxnum();
			b.setNum(++num);
			b.setGrp(num);
			
			// 4��
			if(dao.insert(b)) { // booleanŸ��
				msg = "�Խù� ��� ����";
				url = "list.do";
			}
		} catch(IOException e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	/* <�� ��>
	 * 1. �������� �� 10���� �Խù�
	 *    - pageNum �Ķ���Ͱ��� ���� / ���� ��� 1�μ���(����)
	 * 2. �ֱٿ� ��ϵ� �Խù��� ���� ���� ��ġ
	 *    - �̹� db���� ������
	 * 3. ȭ�鿡 �ʿ��� ������ �Ӽ����� ��� => view�� ����
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		// 1��
		int limit =10;
		int pageNum =1;
		
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		// �Խù� �˻��ϱ⿡�� <�˻�����>
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if(column !=null && column.trim().equals("")) {
			column = null;
		}
		if(find !=null && find.trim().equals("")) { // find�� ���������ʾƵ� �˻� ����
			find = null;
		}
		if(column == null || find == null) { // ��ü�� �˻��ϰڴ�
			column = null;
			find = null;
		}
		
		// 2��
		// int boardcnt = dao.boardCount();
		int boardcnt = dao.boardCount(column, find);
		List<Board> list = dao.list(pageNum, limit, column, find);
		int maxpage = (int)((double)boardcnt/limit + 0.95);
		int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 +1;
		int endpage = startpage +9;
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		/*
		 *  maxpage : �������� ����
			��ü �Խù� �Ǽ� : 21�� => 3������ => pageNum=3
			---> 21.0/10 + 0.95 = (int)(3.05) = 3;
			---> 101.0/10 + 0.95 = (int)(10.1+0.95) = (int)(11.05) = 11;
		 * 
		 * 	pageNum : 2 => 1������
			---> (2/10.0 + 0.9) = ((int)(1.1) *10) +1 = ������������ 1����
			pageNum : 10 => 1������
			---> (10/10.0 +0.9) = ((int)(1.9) -1) *10 = 1���� statpage�� ǥ��
			pageNum : 101 => 11
			---> (11/10.0 +0.9) = ((int))
		 */
		
		// �Խù� ��ȣ�� ����� ������ ������� ���ʷ� ��Ÿ������ �� ��,
		int boardnum = boardcnt - (pageNum -1) *limit;
		
		// 3��
		request.setAttribute("boardcnt", boardcnt);
		request.setAttribute("list", list);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("pageNum", pageNum);
		return new ActionForward();
	}

	/*  <�� ��>
	 *  1. num �Ķ���� ������ ����
		2. num�� �̿��Ͽ� db���� �Խù� ������ ��ȸ
	   	   Board BoardDao.selectOne(num)
	
		3. ��ȸ�� ������Ű��
	       void BoardDao.readcntadd(num)
	
	 	4. ��ȸ�� �Խù� ȭ�鿡 ���
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		Board info = dao.selectOne(num); // num�� �ش��ϴ� �Խù� ��ȸ
		
		// �󼼰�ΰ� info.do�� ��쿡�� num�� �ش��ϴ� ��ȸ�� ����
		// ��, /jsp_study2/model2/board/info.do�� ���
		if(request.getRequestURI().contains("info.do")) {
			dao.readcntadd(num);
		}
		
		request.setAttribute("num", num); // ��������
		request.setAttribute("info", info);
		return new ActionForward();
	}

	/* <��� �ޱ�>
		1. �Ķ���� ���� Board ��ü�� �����ϱ� =============> useBean�׼���ũ ��� �Ұ�
	    - ���� ���� : num / grp / grplevel / grpstep
	    - ��� ���� : name / pass / title / content  ======> ���� ����
	
		2. ���� grp���� ����ϴ� �Խù����� grpstep ���� 1�����ϱ� (�������� grpStep�� +1)
	    - void BoardDao.grpStepAdd(grp, grpstep)

		3. Board ��ü�� db�� insert�ϱ�
	    - num : maxnum+1
	    - grp : ���۰� �����ϰ� ����
	    - grplevel : ���� +1 (��� �ܰ�)
	    - grpstep : ���� +1
	
		4. - ��� ������ : "�亯��� �Ϸ�" �޽��� ��� => list.jsp�� �̵�
	       - ��� ���н� : "�亯��� �����߻�" �޽��� ��� => replyForm.jsp�� �̵�
	 */
	public ActionForward reply(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		// 1������
		Board b = new Board();
		b.setNum(Integer.parseInt(request.getParameter("num")));
		b.setGrp(Integer.parseInt(request.getParameter("grp")));
		b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
		b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
		b.setName(request.getParameter("name"));
		b.setPass(request.getParameter("pass"));
		b.setTitle(request.getParameter("title"));
		b.setContent(request.getParameter("content"));
		
		// 2������ : ���� ���� grpStep�� +1 ���ִ� �Լ�
		dao.grpStepAdd(b.getGrp(), b.getGrpstep());
		System.out.println("num�̶� ������ Grp(group)�� : "+b.getGrp());
		
		// 3������
		int grplevel = b.getGrplevel(); // ��������
		int grpstep = b.getGrpstep(); // ��������
		int num = dao.maxnum();
		
		String msg = "�亯��Ͻ� ���� �߻�";
		String url = "replyForm.do?num="+b.getNum();
		
		b.setNum(++num);
		b.setGrplevel(grplevel +1);
		b.setGrpstep(grpstep +1);
		
		if(dao.insert(b)) {
			msg = "�亯�� ��� �Ϸ�";
			url = "list.do";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	/* <�� ��>
	 * 	1. �Ķ������������ Board ��ü�� ���� ==> multipartRequest
	
		2. ��й�ȣ ����
	    - ��ġ�ϴ� ��� => �Ķ������ �������� �ش� �Խù��� ������ ����
	              => ÷�������� ������ ���� ��� file2 �Ķ������ ������ �ٽ� ����
	    - ����ġ�ϴ� ��� : �����޽��� ��� & updateForm.do�� �̵�
	
		3. - �������� : �������� �޽��� ��� �� info.do �̵�
	       - �������� : �������� �޽��� ��� �� updateForm.do �̵�
	*/
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		String msg =null;
		String url =null;
		
		// useBean�׼��ױ׸� ����� �� �����ϱ�
		// Board��ü�� �Ķ���� ������ ������ ��������
		Board b = new Board();
		String uploadpath = request.getServletContext().getRealPath("/") + "model2/board/file/";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadpath, 10*1024*1024, "euc-kr");
			
			b.setNum(Integer.parseInt(multi.getParameter("num")));
			b.setName(multi.getParameter("name"));
			b.setPass(multi.getParameter("pass"));
			b.setTitle(multi.getParameter("title"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			
			// => ÷�������� ������ ���� ��� file2 �Ķ������ ������ �ٽ� ����
			// ���ϼ����� ���� ���� - �׷��� multi.getParameter("file2")�� ������ setFile1 ����
			if(b.getFile1() ==null || b.getFile1().equals("")) {
				b.setFile1(multi.getParameter("file2"));
			}
			
			// 2 ��й�ȣ ����
			Board dbboard = dao.selectOne(b.getNum());
			
			msg = "��й�ȣ�� Ʋ�Ƚ��ϴ� == ��������";
			url = "updateForm.do?num="+b.getNum();
			
			if(b.getPass().equals(dbboard.getPass())) {
				
				if(dao.update(b)) {
					msg = "�Խù� ������ �����߽��ϴ�";
					url = "info.do?num=" +b.getNum();
				} else {
					msg = "������ �����߽��ϴ�";
					url = "updateForm.do?num=" +b.getNum();
				}
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*  <delete �� ��>
	 *  1. num, pass �Ķ���͸� ������ ����
	
		2. �Էµ� ��й�ȣ�� db ��й�ȣ ����
	   	- Ʋ�� ���, ��й�ȣ ���� �޽��� ��� & deleteForm.jsp�� �̵�
	
		3. ��й�ȣ�� �´� ���,
	    - ���� ���� : ���� ���� �޽��� ��� ��, list.jsp�� �̵�
	    - ���� ���� : ���� ���� �޽��� ��� ��, info.jsp�� �̵�
	*/
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");
		
		String msg =null;
		String url =null;
		
		Board b = dao.selectOne(num);
		
		if(b ==null) { // ���� �� �����Ϸ��� �� ��,
			msg = "�̹� �����ؼ� ���� �Խñ��Դϴ�";
			url = "list.do";
		} else {
			if(pass.equals(b.getPass()) && !pass.trim().equals("")) {
				if(dao.deleteB(b)) {
					msg = "�Խñ� ������ �����߽��ϴ�";
					url = "list.do";
					request.getSession().invalidate();
				} else {
					msg = "�Խñ� ������ �����߽��ϴ�";
					url = "info.do?num=" +b.getNum();
				}
			} else {
				msg = "��й�ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ�����ּ���";
				url = "deleteForm.do?num="+b.getNum();
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "model2/board/imgfile/";
		File f = new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload");
		
		// "CKEditorFuncNum" : �̹� �������ž�, ck editor���� �����̸��� ��������
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
	
}
