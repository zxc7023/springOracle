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
import org.springframework.web.bind.annotation.RequestParam;

import com.my.dao.OrderDAOOracle;
import com.my.vo.Customer;
import com.my.vo.OrderInfo;
import com.my.vo.OrderLine;
import com.my.vo.Product;

@Controller
@RequestMapping("/order/*")
public class OrderController {
	
	@Autowired
	private OrderDAOOracle dao=null;
	
	@RequestMapping("/addorder")
	public String addOrder(HttpSession session) {
		
		Customer c = (Customer) session.getAttribute("loginInfo");
		String forwardURL;
		if (c == null) {
			forwardURL = "customer/loginform";

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
			forwardURL = "forward:/order/orderlist";

		}
		return forwardURL;
	}

	
	@RequestMapping("/orderlist")
	public String orderList(HttpSession session, Model model, @RequestParam(required=false, defaultValue="1day")String info_date) {
		Customer c = (Customer) session.getAttribute("loginInfo");
		String forwardURL;
		if (c == null) {
			forwardURL = "customer/loginform";
			return forwardURL;
		}
		try {
			System.out.println("진입전");
			List<OrderInfo> orderInfoList= dao.selectById(c.getId(),info_date);
			System.out.println("진입후");
			System.out.println(orderInfoList);
			forwardURL = "order/orderlistresult";
			model.addAttribute("orderInfoList", orderInfoList);
			return forwardURL;

		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
