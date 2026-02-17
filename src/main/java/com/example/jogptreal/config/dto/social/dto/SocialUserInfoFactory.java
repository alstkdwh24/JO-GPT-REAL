package com.example.jogptreal.config.dto.social.dto;

import java.util.Map;

public class SocialUserInfoFactory {

    public static SocialUserInfo getSocialUserInfo(String registrationId, Map<String, Object> attributes){
        if (registrationId.equalsIgnoreCase("google")) {
            return new GoogleUserInfo(attributes);
        } else if (registrationId.equalsIgnoreCase("kakao")) {
            return new KakaoUserInfo(attributes);

        } else if (registrationId.equalsIgnoreCase("naver")) {
            return NaverUserInfo(attributes);

        }else{
            throw new IllegalArgumentException("지원되지 않는 로그인 발식입니다." + registrationId);
        }
    }
}
