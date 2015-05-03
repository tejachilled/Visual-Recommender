package com.dv;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FirstPage{	

	@RequestMapping(value="/",method= RequestMethod.GET)
	public ModelAndView LoginPage(HttpServletRequest request) throws Exception {
		System.out.println("LoginPage");
		CriteriaBean bean = new CriteriaBean();		
		bean = getMonths(bean);
		request.getSession().setAttribute("criteria", bean);
		ModelAndView mv = new ModelAndView("FirstPage");
		return mv;
	}

	private CriteriaBean getMonths(CriteriaBean bean) {
		// TODO Auto-generated method stub
		ArrayList<String> months = new ArrayList<String>();
		months.add("January");
		months.add("February");
		months.add("March");
		months.add("April");
		months.add("May");
		months.add("June");
		months.add("July");
		months.add("August");
		months.add("September");
		months.add("October");
		months.add("November");
		months.add("December");
		bean.setDisMonths(months);
		return bean;
	}

	@RequestMapping(value="/getQuestions",method= RequestMethod.POST)
	public ModelAndView getQuestions(@ModelAttribute("bean") CriteriaBean bean,HttpServletRequest request ) {
		System.out.println("getQuestions");
		//CriteriaBean bean = new CriteriaBean();
		//Database.getQuestions();
		ModelAndView mv = new ModelAndView("FirstPage");
		System.out.println("bean month: "+bean.getSelMonth());
		System.out.println("q type : "+bean.getQtype());
		System.out.println(" voteInput : "+bean.getVoteInput());
		try {
			bean = Database.GetTites(bean);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return mv;
		} 
		if(bean.getTitles().size() == 0){
			mv.addObject("msg","No results found!");
		}else{
			mv.addObject("msg","Select any Title from below");
			mv.addObject("number","S.No");
			mv.addObject("titles","Titles");
		}

		//String bar = "[ {'country': 'Question1','visits': 2025 }, {'country': 'China','visits': 1882}, {'country': 'Japan','visits': 1809}, {'country': 'Germany','visits': 1322}]";

		System.out.println("Titles count: "+bean.getTitles().size());
		request.getSession().setAttribute("bean", bean);
		//mv.addObject("bar",bar);
		mv.addObject("bean",bean);
		return mv;
	}
	@RequestMapping(value="/getAnswers",method= RequestMethod.POST)
	public ModelAndView Answers(HttpServletRequest request ) throws Exception {
		System.out.println("getQuestions");
		String qSelected = (String) request.getParameter("qSelected");
		System.out.println("question selected is :"+ qSelected);
		CriteriaBean bean;
		ModelAndView mv = new ModelAndView("SecondPage");
		bean = (CriteriaBean)request.getSession().getAttribute("bean");
		bean.setqSelected(Integer.parseInt(qSelected)+1);
		bean = Database.GetQAnswers(bean);
		if(bean.getQabean().size()>0){
			bean = scalable(bean);
			System.out.println(" answers size: "+bean.getAnswers().size());
			mv.addObject("msg","Select any answer");
			//System.out.println("2nd answer : "+bean.getAnswers().get(3));
		} else{
			mv.addObject("msg","No Answers found!");
		}
		//System.out.println("Question : \n"+bean.getQuestion());
		request.getSession().setAttribute("bean", bean);
		mv.addObject("bean",bean);
		return mv;
	}
	public static int scale(final double valueIn, final double baseMin, final double baseMax, final double limitMin, final double limitMax) {
		return (int) (((limitMax - limitMin) * (valueIn - baseMin) / (baseMax - baseMin)) + limitMin);
	}

	private CriteriaBean scalable(CriteriaBean bean) {
		// TODO Auto-generated method stub
		double baseMin = 0;
		double baseMax = 600;
		final double minRep = bean.getAminRep();
		final double maxRep = bean.getAmaxRep();
		final double minVote = bean.getAminVote();
		final double maxVote = bean.getAmaxVote();
		ArrayList<Integer> aReputation = new ArrayList<Integer>();
		ArrayList<Integer> aVotes = new ArrayList<Integer>();
		ArrayList<Integer> aOrgRep= new ArrayList<Integer>();
		ArrayList<Integer> aOrgVotes= new ArrayList<Integer>();
		ArrayList<String> answers = new ArrayList<String>();
		bean.setAcceptedanswer("no");
		bean.setAcceptedOrgVote(0);
		bean.setAcceptedVote(0);	
		bean.setAcceptedOrgRep(0);
		bean.setAcceptedRep(0);
		for(QandAbean answer : bean.getQabean()){
			if(answer.getAnswerStatus().equalsIgnoreCase("No")){
				baseMin = 0;
				baseMax = 600;
				aOrgRep.add(answer.reputation);
				int newaRep = scale(answer.reputation, minRep, maxRep,baseMin, baseMax);
				System.out.println("answer.reputation : "+answer.reputation);
				aReputation.add(newaRep);
				aOrgVotes.add(answer.votes*6);
				baseMin = 0;
				baseMax = 100;
				int temp = answer.votes;
				if(temp <=0){
					temp = 3;
					aVotes.add(temp);
				}else{
					int newaVote = scale(temp, minVote, maxVote,baseMin, baseMax);
					aVotes.add(newaVote*6);
				}
				answers.add(answer.getAnswer());
			}else{
				baseMin = 0;
				baseMax = 600;
				int newaRep = scale(answer.reputation, minRep, maxRep,baseMin, baseMax);
				bean.setAcceptedOrgRep(answer.reputation);
				bean.setAcceptedRep(newaRep);
				baseMin = 0;
				baseMax = 100;
				int newaVote = scale(answer.votes, minVote, maxVote,baseMin, baseMax);
				System.out.println("accepted answer.vote : "+answer.votes);
				bean.setAcceptedOrgVote(answer.votes*6);
				bean.setAcceptedVote(newaVote*6);	
				bean.setAcceptedanswer(answer.getAnswer());
			}
		}
		System.out.println(" scaled answer.reputation : "+aReputation);
		System.out.println(" orginal answer.reputation : "+aOrgRep);
		System.out.println(" scaled answer.vote : "+aVotes);
		System.out.println(" orginal answer.vote : "+aOrgVotes);
		System.out.println(" scaled accpted answer.reputation : "+bean.getAcceptedRep());
		System.out.println(" org accpted answer.reputation : "+bean.getAcceptedOrgRep());
		System.out.println(" scaled accepted answer.vote : "+bean.getAcceptedVote());
		System.out.println(" org accepted answer.vote : "+bean.getAcceptedOrgVote());
		bean.setaReputation(aReputation);
		bean.setaVotes(aVotes);
		bean.setaOrgRep(aOrgRep);
		bean.setaOrgVotes(aOrgVotes);
		bean.setAnswers(answers);


		return bean;
	}


	
}
