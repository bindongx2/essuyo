package com.webproject.essuyo.utility;


import java.util.*;




public class CodingTest{
	
	public static void main(String[] args) {
	}
	
		/*
		 프래그래머스 -->해시 -->완주하지 못한 선수 마라톤 참가선수중 한사람 빼고 모두 완주했다.
		  완주하지 못한 한사람을 찾는 알고리즘
		 */
		class Solution {
		    public String solution(String[] participant, String[] completion) {
		        String answer = "";
		        Arrays.sort(participant);
				Arrays.sort(completion);
		        int i;
				for(i=0; i<participant.length;i++) {
						
					if(!participant[i].equals(completion[i])) {
						return participant[i];
					}
				}	
				answer = participant[i];
		        
				return answer;
		    }
		}
		
		/*
	 	  자연수N의 각자릿수의 합을 구하는 알고리즘 
		 String stringValue = Integer.toString(int a);
		 int intValue = Integer.parseInt(String a);
		*/
		public class Solution2 {
		    public int solution(int n) {
		        int answer = 0;

		        String typeOfString = Integer.toString(n);
		        for(int k=0; k<typeOfString.length();k++){
		           answer  += Integer.parseInt(typeOfString.substring(k,k+1));
		        }
		        
		        return answer;
		    }
		}
		
		
		/*
		 두배열은  자연수로 구성된 길이가 같은 배열이다. 각 배열에서 하나의 원소를 뽑아 두수를 곱한다음  누적된 값을 모두 더한다. 
		 더한 값이 최소값으로 나오게 하는 알고리즘
		*/
		 public int solution(int []A, int []B)
		    {
		        int answer = 0;
		        Arrays.sort(A);
		        Arrays.sort(B);

		        int length = A.length;
		        for(int i=0; i<length; i++){
		            answer += A[length-1-i] * B[i];
		        }
		    return answer;
		    }
		
		 class Solution5 {
			   public int[] solution(int[] prices) {
						     
			                     int length = prices.length;
			                    int[] answer = new int[length]; 
						        
						        for(int i=0; i<length-1; i++) {
						        	int count = 1;
						        	
						        	for(int k=1; k<length-1; k++) {
						        		if(prices[i] <= prices[k]) {
						        			count++;
						        		}
						        	}
						      
						        answer[i] = count;
						        }
			                 answer[length-1] = 0;
						        
						        return answer;
						    }
			}
		 
		 
		 /*
		  2018윈터코딩 --> 스킬트리
		 */
	    public int solution(String skill, String[] skill_trees) {
	        int answer = 0;
	        ArrayList<String> skillTrees = new ArrayList<String>(Arrays.asList(skill_trees));
	        //ArrayList<String> skillTrees = new ArrayList<String>();
	        Iterator<String> it = skillTrees.iterator();
	
	        while (it.hasNext()) {
	            if (skill.indexOf(it.next().replaceAll("[^" + skill + "]", "")) != 0) {
	            	//replaceAll : skill에 있는 문자열을 제외한 나머지 문자열은 모두 ""으로 변경
	            	//skill.indexOf : skill과 관련된 문자열로 표현한 후  indexof = 0이 아닌값들은 모두 remove
	                it.remove();
	            }
	        }
	        answer = skillTrees.size();
	        return answer;
	    }
		
}
