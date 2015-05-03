package com.dv;

import java.util.ArrayList;

public class CriteriaBean {
	private ArrayList<String> disMonths;
	private String qtype;
	private String selMonth;
	private String voteInput;
	private String quesStatus;
	private int qSelected;
	private int minVotes;
	private int minViews;
	private ArrayList<String> titles;
	private ArrayList<String> links;
	private ArrayList<Integer> views;
	private ArrayList<Integer> votes;
	private ArrayList<Integer> aReputation;
	private ArrayList<Integer> aVotes;
	private ArrayList<Integer> aOrgRep;
	private ArrayList<Integer> aOrgVotes;
	private String question;
	private ArrayList<QandAbean> qabean;
	public int acceptedRep;
	public int acceptedVote;
	public int acceptedOrgRep;	
	public int acceptedOrgVote;
	public int aminRep;
	public int amaxRep;
	public int aminVote;
	public int amaxVote;
	private String acceptedanswer;
	public ArrayList<String> answers;
	

	public int getAcceptedOrgRep() {
		return acceptedOrgRep;
	}
	public void setAcceptedOrgRep(int acceptedOrgRep) {
		this.acceptedOrgRep = acceptedOrgRep;
	}
	public int getAminRep() {
		return aminRep;
	}
	public void setAminRep(int aminRep) {
		this.aminRep = aminRep;
	}
	public int getAmaxRep() {
		return amaxRep;
	}
	public void setAmaxRep(int amaxRep) {
		this.amaxRep = amaxRep;
	}
	public int getAminVote() {
		return aminVote;
	}
	public void setAminVote(int aminVote) {
		this.aminVote = aminVote;
	}
	public int getAmaxVote() {
		return amaxVote;
	}
	public void setAmaxVote(int amaxVote) {
		this.amaxVote = amaxVote;
	}
	
	public ArrayList<String> getDisMonths() {
		return disMonths;
	}
	public void setDisMonths(ArrayList<String> disMonths) {
		this.disMonths = disMonths;
	}
	public String getQtype() {
		return qtype;
	}
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	public String getSelMonth() {
		return selMonth;
	}
	public void setSelMonth(String selMonth) {
		this.selMonth = selMonth;
	}
	public String getQuesStatus() {
		return quesStatus;
	}
	public void setQuesStatus(String quesStatus) {
		this.quesStatus = quesStatus;
	}
	public int getMinVotes() {
		return minVotes;
	}
	public void setMinVotes(int minVotes) {
		this.minVotes = minVotes;
	}
	public int getMinViews() {
		return minViews;
	}
	public int getAcceptedRep() {
		return acceptedRep;
	}
	public void setAcceptedRep(int acceptedRep) {
		this.acceptedRep = acceptedRep;
	}
	public void setMinViews(int minViews) {
		this.minViews = minViews;
	}
	public ArrayList<String> getTitles() {
		return titles;
	}
	public void setTitles(ArrayList<String> titles) {
		this.titles = titles;
	}
	public String getVoteInput() {
		return voteInput;
	}
	public int getAcceptedOrgVote() {
		return acceptedOrgVote;
	}
	public void setAcceptedOrgVote(int acceptedOrgVote) {
		this.acceptedOrgVote = acceptedOrgVote;
	}
	public int getAcceptedVote() {
		return acceptedVote;
	}
	public void setAcceptedVote(int acceptedVote) {
		this.acceptedVote = acceptedVote;
	}
	public void setVoteInput(String voteInput) {
		this.voteInput = voteInput;
	}
	public int getqSelected() {
		return qSelected;
	}
	public void setqSelected(int qSelected) {
		this.qSelected = qSelected;
	}
	public ArrayList<QandAbean> getQabean() {
		return qabean;
	}
	public void setQabean(ArrayList<QandAbean> qabean) {
		this.qabean = qabean;
	}
	public ArrayList<String> getLinks() {
		return links;
	}
	public void setLinks(ArrayList<String> links) {
		this.links = links;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public ArrayList<Integer> getViews() {
		return views;
	}
	public void setViews(ArrayList<Integer> views) {
		this.views = views;
	}
	public ArrayList<Integer> getVotes() {
		return votes;
	}
	public void setVotes(ArrayList<Integer> votes) {
		this.votes = votes;
	}
	public ArrayList<Integer> getaReputation() {
		return aReputation;
	}
	public void setaReputation(ArrayList<Integer> aReputation) {
		this.aReputation = aReputation;
	}
	public ArrayList<Integer> getaVotes() {
		return aVotes;
	}
	public void setaVotes(ArrayList<Integer> aVotes) {
		this.aVotes = aVotes;
	}
	public ArrayList<Integer> getaOrgRep() {
		return aOrgRep;
	}
	public void setaOrgRep(ArrayList<Integer> aOrgRep) {
		this.aOrgRep = aOrgRep;
	}
	public ArrayList<String> getAnswers() {
		return answers;
	}
	public void setAnswers(ArrayList<String> answers) {
		this.answers = answers;
	}
	public ArrayList<Integer> getaOrgVotes() {
		return aOrgVotes;
	}
	public void setaOrgVotes(ArrayList<Integer> aOrgVotes) {
		this.aOrgVotes = aOrgVotes;
	}
	
	public String getAcceptedanswer() {
		return acceptedanswer;
	}
	public void setAcceptedanswer(String acceptedanswer) {
		this.acceptedanswer = acceptedanswer;
	}
}
