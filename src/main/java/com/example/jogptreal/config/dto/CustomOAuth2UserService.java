package com.example.jogptreal.config.dto;

import com.example.jogptreal.config.dto.social.dto.SocialUserInfo;
import com.example.jogptreal.config.dto.social.dto.SocialUserInfoFactory;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Map;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException  {

       OAuth2User oAuth2User=super.loadUser(userRequest);

       //2. 어떤 소셜 로그인인지 확인
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        System.out.println("로그인 provider: " + registrationId);

        Map<String, Object> attributes = oAuth2User.getAttributes();
        // provider별로 attributes 구조가 다르니 파싱 / 정규화(팩토리/어댑터)

        SocialUserInfo info = SocialUserInfoFactory.getSocialUserInfo(registrationId, attribute);

        String providerId = info.getProviderId();
        String email = info.getEmail();
        String name = info.getName();
        String imageUrl= info.getImageUrl();
        String provider = info.getProvider();

        return new DefaultOAuth2User(
                Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),attributes, "id"
        );    }
}
