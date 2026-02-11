package com.example.jogptreal.config.dto.social;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import java.util.HashMap;
import java.util.Map;

@ToString
@Builder(access = AccessLevel.PRIVATE) //Builder 메서드를 외부에서 사용하지 않으므로, private 제어자로 지정
@Getter
public class OAuth2Attribute {

    private Map<String, Object> attributes; // 사용자 속성 정보를 담는 Map

    private String attributeKey; //사용자 속성의 키 값
    private String memberId;
    private String name;
    private String picture;
    private String provider; //제공자 정보


    // 서비스에 따라 OAuth2Attribute 객체를 생성하는 메서드
    static OAuth2Attribute of(String provider, String attributeKey, Map<String, Object> attributes) {
        System.out.println("카카오 로그인 테스트"+provider);
        switch (provider) {
            case "google":
                return OfGoogle(provider, attributeKey, attributes);
            case "kakao":
                return OfKakao(provider, "id", attributes);
            case "naver":
                return OfNaver(provider, "id", attributes);
            default:
                throw new RuntimeException();
        }
    }
    /*
     * Google 로그인일 경우 사용하는 메서드, 사용자 정보가 따로  Wrapping되지 않고 제공되어, 바로 get() 메서드로 접근이 가능하다.
     * */

    private static OAuth2Attribute OfGoogle(String provider, String attributeKey, Map<String, Object> attributes) {
        return OAuth2Attribute.builder()
                .memberId((String) attributes.get("email"))
                .provider(provider)
                .attributes(attributes)
                .attributeKey(attributeKey)
                .build();
    }

    /*
     * kakao 로그인일 경우 사용하는 메서드, 필요한 사용자 정보가 kakaoAccount -> kakaoProfile 두번 감싸져 있어서,
     * 두번 get() 메서드를 이용해 사용자 정보를 담고있는 Map을 꺼내야 한다.
     *
     * */
    private static OAuth2Attribute OfKakao(String provider, String attributeKey, Map<String, Object> attributes) {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> kakaoProfile = (Map<String, Object>) kakaoAccount.get("profile");
        return OAuth2Attribute.builder()
                .memberId((String) kakaoAccount.get("email"))

                .provider(provider)
                .attributes(attributes)
                .attributeKey(attributeKey)
                .build();

    }

    /*
     * Naver 로그인일 경우 사용하는 메서드, 필요한 사용자 정보가 response Map에 감싸져 있어서, 한번 get() 메서드를 이용해 사용자 정보를 담고있는 Map을 꺼내야 한다.
     *
     * */

    private static OAuth2Attribute OfNaver(String provider, String attributeKey, Map<String, Object> attributes) {
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        return OAuth2Attribute.builder()
                .memberId((String) response.get("email"))

                .attributes(response)
                .provider(provider)
                .attributeKey(attributeKey)
                .build();
    }

    // OAuth2User 객체에 넣어주기 위해서 Map으로 값들을 반환해준다.
    Map<String, Object> convertToMap(){
        Map<String, Object> map = new HashMap<>();
        map.put("id",attributeKey);
        map.put("key",attributeKey);
        map.put("memberId",memberId);
        map.put("provider",provider);

        return map;
    }
}
