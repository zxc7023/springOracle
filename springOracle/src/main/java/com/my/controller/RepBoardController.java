package com.my.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.my.dao.RepBoardDAOOracle;
import com.my.vo.PageMaker;
import com.my.vo.RepBoard;
import com.my.vo.SearchCriteria;

@Controller
@RequestMapping(value = "/repboard/*")
public class RepBoardController {

	@Autowired
	private RepBoardDAOOracle dao = null;

	@RequestMapping(value = "/repboardlist", method = RequestMethod.GET)
	public String boardList(Model model, SearchCriteria cri) {
		System.out.println("/repboardlist" + "\t" + cri.getPage() + cri.toString());
		List<RepBoard> list = new ArrayList<>();
		try {
			list = dao.selectList(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalConunt(dao.countPaging(cri));
			model.addAttribute("pageMaker", pageMaker);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("boardList", list);
		// model.addAttribute("searchItem", searchItem);
		// model.addAttribute("searchValue", searchValue);
		System.out.println(list);
		String forwardURL = "/repboard/repboardlist";
		return forwardURL;
	}

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(@RequestParam(defaultValue="0")String parent_no,Model model) {
		System.out.println("/insert" + " /get  no=" + parent_no);
		model.addAttribute("parent_no",parent_no);
		return "repboard/repboard_insert";
	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(@ModelAttribute RepBoard repboard, Model model) {
		System.out.println("/insert" + " /post no=" + repboard.getParent_no());
		String msg = "-1";
		try {
			dao.insert(repboard);
			msg = "1";
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forwardURL = "result";
		return forwardURL;
	}

	@RequestMapping("/repboarddetail")
	public String repboardDetail(String no, Model model,SearchCriteria criteria) {
		System.out.println("/repboarddetail" + no + "\t"+ criteria);

		String searchNo = no;
		int sNo = Integer.parseInt(searchNo);
		HashMap<String, List<RepBoard>> map = null;
		try {
			map = dao.selectDetailData(sNo);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(map);
		model.addAttribute("no",no);
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("preBoard",map.get("preBoard"));
		model.addAttribute("nextBoard",map.get("nextBoard"));
		
		String forwardURL = "repboard/repboard_detail";
		return forwardURL;
	}

	@RequestMapping("/isauthorization.do")
	public String isauthorization(String check, String boardno, Model model) {
		if (check != null) {
			model.addAttribute("check", check);
			model.addAttribute("boardno", boardno);
		} else {
			model.addAttribute("check", null);
		}
		String forwardURL = "/pwdcheck.jsp";
		return forwardURL;
	}

	@RequestMapping("/checkpassword.do")
	public String checkpassword(String pwd, String boardno, Model model) {
		String BoardNumber = boardno;
		String msg = "-1";

		try {
			if (dao.chkPassword(Integer.parseInt(BoardNumber), pwd)) {
				msg = "1";
			} else {
				msg = "-1";
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("msg", msg);
		String forwardURL = "/result.jsp";

		return forwardURL;
	}

	@RequestMapping("/repboarddelete.do")
	public String repboarddelete(String boardno, Model model) {
		System.out.println("삭제");
		String msg = "-1";
		try {
			dao.delete(Integer.parseInt(boardno));
			msg = "1";
		} catch (Exception e) {
			// TODO: handle exception
			msg = "-1";
		} finally {
			System.out.println(msg);
		}
		model.addAttribute("msg", msg);
		String forwardURL = "/result.jsp";

		return forwardURL;
	}

	@RequestMapping("/selectdata.do")
	public String selectdata(String boardno, Model model) {
		String boardNumber = boardno;
		List<RepBoard> list = null;
		try {
			list = dao.selectByNo(Integer.parseInt(boardNumber));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("selectData", list);
		String forwardURL = "/update.jsp";
		System.out.println(list);
		return forwardURL;
	}

	@RequestMapping("/update.do")
	public String update(String no, String subject, String content, String password, Model model) {
		System.out.println(no + subject + content + password + "");
		String msg = "-1";

		try {
			/* dao.update(Integer.parseInt(no), subject, content, password); */
			msg = "1";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			msg = "-1";
			e.printStackTrace();
		}
		model.addAttribute("msg", msg);
		String forward = "/result.jsp";
		return forward;
	}

}