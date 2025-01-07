
public class ArmstrongNumber {

	public static void main(String[] args) {
		int num = 8208;
		
		int temp1 = num;
		int temp2 = 0;
		int count = 0;
		
		count = String.valueOf(num).length();
		
		while(temp1 != 0) {
			int r = temp1 % 10;
			temp2 += Math.pow(r,count);
			temp1 = temp1 / 10;
		}
		
		System.out.println(" num "+ num + " " + "temp2 "+ temp2);
			

	}

}
