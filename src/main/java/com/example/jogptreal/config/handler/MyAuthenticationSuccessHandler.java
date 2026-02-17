package com.example.jogptreal.config.handler;

import com.example.jogptreal.config.jwt.JWTUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Slf4j
@Component
@RequiredArgsConstructor
public class MyAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JWTUtils jwtUtils;
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException,SecurityException {

       //OAuth2User로 캐스팅하여 인증된 사용자 정보를 가져온다.
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();

        //사용자 이메일을 가져온다
        String memberId = oAuth2User.getAttribute("email");
        //서비스 제공 플랫폼(google, kakao, naver)이 어디인지 가져온다.
        String provider = oAuth2User.getAttribute("provider");
        // CustomOAuth2UserService에서 셋팅한 로그이인한 회원 존재 여부를 가져온다.
        boolean isExist = oAuth2User.getAttribute("exist");

        //OAuth2User 로 부터 Role을 얻어온다.
        String role = oAuth2User.getAuthorities().stream().findFirst().orElseThrow(IllegalAccessError::new).getAuthority(); //Role을 가져온다.
        Long expiredMs = 1000L * 60 * 60; // 1시간
        if(isExist){
            String token = jwtUtils.createToken(memberId, role,expiredMs);
            log.info("jwtToken = {}", token);

            // accessToken을 쿼리스트링에 담는 url을 만들어준다.
            String targetUrl =  UriComponentsBuilder.fromUriString("http://localhost:8086/auth/token")
                    .queryParam("accessToken", token)
                    .build()
                    .encode(StandardCharsets.UTF_8)
                    .toUriString();
            log.info("targetUrl = {}", targetUrl);

            getRedirectStrategy().sendRedirect(request, response, targetUrl);
        }else{
            //회원이 존재하지 않을경우, 서비스 제공자와 email을 쿼리스트링으로 전달하는 url을 만들어준다.
            String targetUrl = UriComponentsBuilder.fromUriString("http://localhost:8086")
                    .queryParam("email", (String) oAuth2User.getAttribute("email"))
                    .queryParam("provider",provider)
                    .build()
                    .encode(StandardCharsets.UTF_8)
                    .toUriString();

            //회원가입 페이지로 리다이렉트 시킨다.
            getRedirectStrategy().sendRedirect(request, response, targetUrl);
        }
    }
}
