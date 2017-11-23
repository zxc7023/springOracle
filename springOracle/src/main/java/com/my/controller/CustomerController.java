package com.my.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.my.service.CustomerService;
import com.my.vo.Customer;

@Controller
@RequestMapping(value = "/customer/*")
@SessionAttributes("loginInfo")
public class CustomerController {

	@Autowired
	private CustomerService service;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "customer/loginform";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String id, String pwd, Model model, HttpSession session) {
		String msg = "-1";
		try {
			Customer c = service.login(id, pwd);
			model.addAttribute("loginInfo", c);
			session.setMaxInactiveInterval(60 * 60);
			msg = "1";
			System.out.println(c.getId() + "유저 접속");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 응답할 페이지에게 위임하는 foward 부분
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request, Model model, HttpSession session, SessionStatus status) {
		status.setComplete();
		model.addAttribute("msg", request.getContextPath());
		String forwardURL = "/";
		return forwardURL;
	}

	@RequestMapping(value = "/signupform", method = RequestMethod.GET)
	public void signupform() {
	}

	@RequestMapping(value = "/signupform", method = RequestMethod.POST)
	public String signup(String id, @Param("pwd") String pwd, String name, Model model) {
		String msg = "-1";
		try {
			service.regist(new Customer(id, pwd, name));
			msg = "1";
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

	@RequestMapping(value = "/dupchkid", method = RequestMethod.POST)
	public String dupchkid(String id, Model model) {
		String msg = "-1";
		Customer c = null;
		try {
			c = service.findById(id);
			if (c != null) {
				msg = "1";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

	@RequestMapping(value = "/customerdetail")
	public String customerdetail(HttpSession session, Model model) {
		System.out.println("수정전");
		Customer c = (Customer) session.getAttribute("loginInfo");
		if( c==null) {
			return "customer/loginform";
		}
		model.addAttribute("customer", c);
		String forwardURL = "customer/customerdetail";
		return forwardURL;
	}

	@RequestMapping(value = "/updatecustomer" , method = RequestMethod.POST)
	public String updatecustomer(Customer c, Model model) {
		String msg = "-1";
		System.out.println("수정후");
		try {
			System.out.println(c);
			//Customer c = new Customer(id, pwd, name);
			service.modify(c);
			model.addAttribute("loginInfo", c);
			msg = "1";

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

	@RequestMapping(value = "/deletecustomer")
	public String leave(String id, Model model, /* HttpSession session */SessionStatus status) {
		String msg = "-1";
		try {
			Customer c = new Customer(id, null, null);
			service.remove(c);
			status.setComplete();
			msg = "1";

		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

}
