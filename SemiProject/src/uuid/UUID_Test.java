package uuid;

import java.util.UUID;

public class UUID_Test {
	public static void main(String[] args) {
		// --- UUID 생성 ---
		//Universally Unique IDentifier
		//	32자리의 16진수를 생성해준다
		//	8-4-4-4-12 개씩 구분해서 생성한다
		
		//랜덤 UUID 생성
		UUID uuid = UUID.randomUUID(); //랜덤 UID 생성
		
		//UUID를 문자열(String)로 변환
		System.out.println(uuid.toString());
		
		//전체 UUID중에서 앞에 한 그룹(8자리)를 추출)
		System.out.println( uuid.toString().split("-")[0] );
		
	}
}






