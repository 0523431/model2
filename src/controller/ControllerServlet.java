package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

// Ȯ���ڰ� .me�� �Ǹ�, ���� ���� �� survlet�� �����
@WebServlet(urlPatterns= {"*.me"}, initParams = {@WebInitParam(name="properties", value="action.properties")})
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Map<String,Action> commandMap = new HashMap<String,Action>();
	
    public ControllerServlet() {
        super();
    }
    
    // ���� �ʿ��� 
    @Override
    public void init(ServletConfig config) throws ServletException {
    	String props = config.getInitParameter("properties");
    	Properties pr = new Properties(); // Properties�� ���� Ŭ���� : Hashtable < Map�� ����
    	FileInputStream f = null;
    	try {
    		f = new FileInputStream(config.getServletContext().getRealPath("/")+"WEB-INF/"+props);
    		pr.load(f); // action.properties������ �о properties��ü�� �������
    	} catch(IOException e) {
    		throw new ServletException(e);
    	} finally {
    		try {
    			if(f !=null) {
    				f.close();
    			}
    		} catch(IOException e) { }
    	}
    	for(Object k : pr.keySet()) {
    		String command = (String)k;
    		String className = pr.getProperty(command);
    		
    		try {
    			// ���Ⱑ ����Ȱ� action.properties
    			Class commandClass = Class.forName(className.trim()); // ������ ���� ������ ���� ����
    			Object commandObj = commandClass.newInstance(); // class�� ��üȭ(�ش� Ŭ�����κ��� ����������� === ���� �̷��� ����� �ȵǴ°Ŷ� ���� �׾���)
    			commandMap.put(command, (Action)commandObj); // commandMap��ü�� ���� �־���
    		} catch(Exception e) {
    			throw new ServletException(e);
    		}
    	}
    }
    
    // commandMap
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("euc-kr"); // �ѱ� �Ķ���͸� �б� ���ؼ�
		
		Action action = null;
		ActionForward forward = null;
		String command = null;
		try {
			// command : /model2/hello.me���� �о���� �ǰ� �� ���� key���� ��
			command = request.getRequestURI().substring(request.getContextPath().length());
			// action : Action�������̽��� ������ ���� ��ü
			//          action.HelloAction ���� �� ����
			action = commandMap.get(command);
			forward = action.execute(request, response);
		} catch(NullPointerException e) {
			e.printStackTrace();
			forward = new ActionForward(false, null);
			// forward = new ActionForward(); ()���� ��� ����
		} catch(Exception e) {
			throw new ServletException(e);
		}
		
		if(forward !=null) {
			if(forward.isRedirect()) { // isRedirect()�̰� boolean�ڷ��� : true or false
				response.sendRedirect(forward.getView());
			} else {
				
				// forward.getView() : action()Ŭ�������� ���� view �̸�
				//                     addForm.jsp
				// 
				if(forward.getView() == null) {
					forward.setView(command.replace(".me",".jsp"));
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		} else response.sendRedirect("nopage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
