package com.example.jogptreal.config.security;


/*
 * Spring Security Config
 * */


import com.example.jogptreal.config.dto.social.CustomOAuth2UserService;
import com.example.jogptreal.config.jwt.JWTFilter;
import com.example.jogptreal.config.jwt.JWTUtils;
import com.example.jogptreal.config.jwt.LoginFilter;
import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Collections;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@Slf4j
public class SecurityConfig {

    private final AuthenticationConfiguration authenticationConfiguration;
    private final JWTUtils jwtUtils;
    private final CustomOAuth2UserService customOAuth2UserService;

    /*
     * Spring Security의 AuthenticationManager 를 빈으로 등록
     * - 로그인 시 사용자의 인증(Authentication)을 담당
     * */

    @Bean
    public AuthenticationManager authenticationManager() throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    /*
     * 비밀번호 암호화를 위한 BCryptPasswordEncoder 빈 등록
     * - 회원가입 시 비밀번호를 안전하게 암호화하여 저장
     * */

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /*
     * CORS 설정을 위한 Bean 등록
     * - 프론트엔트(React 등)에서 API 요청 시 CORS 문제 해결
     * */

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        return request -> {
            CorsConfiguration corsConfiguration = new CorsConfiguration();
            corsConfiguration.setAllowedOrigins(Collections.singletonList("http://localhost:8086")); // 허용할 도메인
            corsConfiguration.setAllowedMethods(Collections.singletonList("*")); // 모든 HTTP 메서드 허용
            corsConfiguration.setAllowCredentials(true);
            corsConfiguration.setAllowedHeaders(Collections.singletonList("*"));  //모든 헤더 허용
            corsConfiguration.setExposedHeaders(Collections.singletonList("Authorization")); // Authorization 헤더 노출
            corsConfiguration.setMaxAge(3600L);
            return corsConfiguration;

        };
    }

    /*
     * Spring Security 필터 체인 설정
     * - JWT 인증을 기반으로 한 보안 설정 적용
     * */

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(cors -> cors.configurationSource(corsConfigurationSource())) //CORS 설정 적용
                .csrf(AbstractHttpConfigurer::disable) //JWT 사용시 CSRF 보호 비 활성화
                .formLogin(AbstractHttpConfigurer::disable) //  기본 로그인 폼 비활성화 (JWT 사용)
                .httpBasic(AbstractHttpConfigurer::disable) //HTTP Basic 인증 비활성화
                .headers(headers -> headers.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable))

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login/**", "/login/oauth2/**", "/", "/signUp", "/home/**", "/css/**", "/js/**", "/image/**", "/home/**", "/oauth2/**", "/login/oauth2/**", "/joGpt/**").permitAll() // 로그인, 회원가입, 홈은 누구나 접근 가능, 여기에 있는 url 조건만 누구나 접근 가능
                        .requestMatchers("/admin").hasAuthority("ADMIN")  // /admin 경로는 ADMIN 권한이 필요
                        .anyRequest().authenticated())  //그 외의 요청은 인증된 사용자만 접근 가능

                // JWT 필터 추가 (기존 UsernamePasswordAuthenticationFilter 이전에 실행)
                .addFilterBefore(new JWTFilter(jwtUtils), UsernamePasswordAuthenticationFilter.class)

                // 로그인 필터 추가 (JWTFilter 실행 후 JWT 발급 처리)
                .addFilterAfter(new LoginFilter(authenticationManager(), jwtUtils), JWTFilter.class)

                //로그인 필터 추가 (JWTFilter 실행 후 JWT 발급 처리)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .oauth2Login(oauth2 -> oauth2
                        .userInfoEndpoint(userInfo ->
                                userInfo.userService(customOAuth2UserService)
                        )
                        .successHandler((req, res, auth) -> {

                            // 1) 카카오 고유 id (nameAttributeKey가 id면 auth.getName()이 id)
                            String kakaoId = auth.getName(); // 예: "4745985224"
                            String memberId = "kakao_" + kakaoId;

                            // 2) 우리 JWT 발급
                            String jwt = jwtUtils.createToken(memberId, "USER", 60 * 60 * 1000L);
                            log.debug("jwt토큰생성{}",jwt);
                            // 3) 브라우저에 저장 (HttpOnly 쿠키 추천)
                            Cookie cookie = new Cookie("ACCESS_TOKEN", jwt);
                            cookie.setHttpOnly(true);
                            cookie.setPath("/");
                            // cookie.setSecure(true); // https면 true
                            res.addCookie(cookie);

                            // 4) 이동
                            res.sendRedirect("/home/GPT-Home");
                        })

                );

        return http.build();
    }
}
