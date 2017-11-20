package com.my.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
@SessionAttributes("loginInfo")
public class CustomerController {
	
	@Autowired
	private CustomerService service;
	
	@RequestMapping(value = "/login.do", method=RequestMethod.GET)
	public String login() {
		return "loginform";
	}
	
	@RequestMapping(value = "/logincheck.do", method = RequestMethod.POST)
	public String login(String id, String pwd, Model model, HttpSession session) {
		String msg = "-1";
		try {
			System.out.println(id+"\t"+pwd);
			Customer c = service.login(id, pwd);
			model.addAttribute("loginInfo", c);
			session.setMaxInactiveInterval(60*60);
			msg = "1";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 응답할 페이지에게 위임하는 foward 부분
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpServletRequest request,Model model,HttpSession session,SessionStatus status){
		status.setComplete();
		model.addAttribute("msg",request.getContextPath());
		String forwardURL = "result.jsp";
		return forwardURL;
	}

}
