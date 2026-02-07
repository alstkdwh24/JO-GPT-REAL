package com.example.jogptreal.config.jwt;


import com.example.jogptreal.member.entity.Role;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Component
public class JWTUtils {

    private final SecretKey secretKey;

    /*
     * 생성자에서 application.properties에 저장된 SecretKey 값을 가져와 설정
     * */
    public JWTUtils(@Value("${spring.jwt.secret}") String secret) {
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    /*
     * JWT 에서 memberId 추출
     * */

    public String getUsername(String token) {

        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .get("username", String.class);
    }

    /*
     * JWT에서 Role(권한) 추출
     * */
    public String getRole(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .get(Role.class.getName(), String.class);
    }

    /*
     * JWT 만료 여부 확인
     * */

    public Boolean isTokenExpired(String token) {
        return Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .getExpiration()
                .before(new Date());
    }

    /*
     * JWT 생성 메서드
     * - memberId, role(권한), 만료 시간 (expiredMs) 을 포함한 JWT 발급
     * */

    public String createToken(String memberId, String role, Long expiredMs) {
        return Jwts.builder()
                .claim("memberId", memberId)
                .claim("role", role)
                .issuedAt(new Date(System.currentTimeMillis())) //발급시간
                .expiration(new Date(System.currentTimeMillis() + expiredMs))
                .signWith(secretKey) //비밀키를 사용하여 서명
                .compact();
    }
}
