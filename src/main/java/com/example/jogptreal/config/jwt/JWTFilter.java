package com.example.jogptreal.config.jwt;

import com.example.jogptreal.config.dto.CustomUserDetails;
import com.example.jogptreal.member.entity.Members;
import com.example.jogptreal.member.entity.Role;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
@Component

@Slf4j
@RequiredArgsConstructor
public class JWTFilter extends OncePerRequestFilter {

    private final JWTUtils jwtUtils;
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        // Authorization 헤더에서 JWT 토큰 추출
        String authorizationHeader = request.getHeader("Authorization");


        if(authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")){
            filterChain.doFilter(request, response);
            return;
        }

        // "Bearer " 이후의토큰 값만 추출
        String token = authorizationHeader.substring(7);

        try{
            if(jwtUtils.isTokenExpired(token)){
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "토큰이 완료되었습니다.");
                return;
            }

            String memberId = jwtUtils.getUsername(token);
            Role role = Role.valueOf(jwtUtils.getRole(token));

            Members members = Members.builder()
                    .memberId(memberId)
                    .userPw("ss")
                    .role(role)
                    .build();


            CustomUserDetails customUserDetails = new CustomUserDetails(members);
            Authentication authentication = new UsernamePasswordAuthenticationToken( customUserDetails, null, customUserDetails.getAuthorities() );

            // SecurityContext에 인증 정보 저장 (STATLESS 모드이므로 요청 종료 시 소멸)
            if(SecurityContextHolder.getContext().getAuthentication() == null){
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }



        }catch (Exception e){

            log.error(e.getMessage());
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, e.getMessage());
        }
        filterChain.doFilter(request, response);
    }
}
