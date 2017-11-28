package com.my.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.my.dao.OrderDAOOracle;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

@Controller
public class OrderController {
	
	@Autowired
	private OrderDAOOracle dao=null;
	
	@RequestMapping("/addorder")
	public String addOrder(HttpSession session) {
		
		Customer c = (Customer) session.getAttribute("loginInfo");
		String forwardURL;
		if (c == null) {
			forwardURL = "loginform.jsp";

		} else {
			// cart정보가져오고
			// 정보들을 order_line,info에 insert
			//
			HashMap<Product, Integer> cart = (HashMap) session.getAttribute("cart");
			OrderInfo info = new OrderInfo();

			info.setInfo_c(c);
			List<OrderLine> lines = new ArrayList<>();
			Set<Product> products = cart.keySet();
			for (Product p : products) {
				lines.add(new OrderLine(0, p, cart.get(p)));
			}
			info.setLines(lines);
			try {
				dao.insert(info);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			session.removeAttribute("cart");
			forwardURL = "orderlist.do";

		}
		return forwardURL;
	}

	
	@RequestMapping("/orderlist.do")
	public String orderList(HttpSession session,Model model) {
		Customer c = (Customer) session.getAttribute("loginInfo");
		String forwardURL;
		if (c == null) {
			forwardURL = "loginform.jsp";
			return forwardURL;
		}
		try {
			List<OrderInfo> customerInfoList= dao.selectById(c.getId());
			
			forwardURL = "orderlistresult.jsp";
			model.addAttribute("customerInfoList", customerInfoList);
			return forwardURL;

		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
