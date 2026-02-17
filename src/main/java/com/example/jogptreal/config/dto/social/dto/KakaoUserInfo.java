package com.example.jogptreal.config.dto.social.dto;

import java.util.Map;

public class KakaoUserInfo implements SocialUserInfo{

    private Map<String, Object> attributes;

    public KakaoUserInfo(Map<String, Object> attributes){
        this.attributes = attributes;
    }
    @Override
    public String getProviderId() {

        Object responseObj = attributes.get("response");

        if (responseObj instanceof Map<?, ?> responseMap) {

            Object id = responseMap.get("id");

            if (id != null) {
                return id.toString();
            }
        }

        return null; // 또는 예외 처리
    }

    @Override
    public String getName() {
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");

        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
        return profile.get("nickname").toString();
    }

    @Override
    public String getEmail() {
        Map<String, Object> response = (Map<String, Object>) attributes.get("response");
        return response.get("email").toString();
    }

    @Override
    public String getImageUrl() {
        Map<String, Object> response =
                (Map<String, Object>) attributes.get("response");

        return response.get("profile_image").toString();    }

    @Override
    public String getProvider() {
        return "naver";
    }
}
