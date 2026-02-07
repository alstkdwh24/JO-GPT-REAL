package com.example.jogptreal.member.service;

import com.example.jogptreal.member.dto.request.SignUpDto;
import com.example.jogptreal.member.entity.Members;
import com.example.jogptreal.member.repository.jpa.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    //왜 PasswordConfig 클래스를 임포트하지 않는 이유는 이 클래스는 빈을 등록하는 클래스이고 메서드가 빈으로 등록이 되었으면 실행할때 자동으로 이 메서드가 실행된다.
    //PasswordEncoder는 규칙(인터페이스)이고,BCrypPasswordEncoder 그 규칙의 구현체이다.

    /*
     * 회원가입 기능
     * - 중복된 username 체크
     * - 비밀번호 암호화 후 저장
     * */

    @Transactional
    public void signUp(SignUpDto signUpDto) {
        validateDuplicateUsername(signUpDto.getMemberId());
        Members members = new Members();
        members.changeMemberId(signUpDto.getMemberId());
        members.changeRole(signUpDto.getRole());
        members.changeAge(signUpDto.getAge());
        members.changeGender(signUpDto.getGender());
        members.changeName(signUpDto.getName());
        members.changePhone(signUpDto.getPhone());
        members.changeUserPw(passwordEncoder.encode(signUpDto.getUserPw()));

        memberRepository.save(members);
    }

    /*
     * 중복된 username 체크
     *
     * */

    private void validateDuplicateUsername(String memberId) {
        if (memberRepository.existsByMemberId(memberId)) {
            log.warn("중복된 아이디 입니다: {}" + memberId);
        }
    }

    /*
     * Members 엔티티 생성 (비밀번호 암호화 적용)
     * */

    private Members createUserEntity(SignUpDto signUpDto) {
        return Members.builder()
                .memberId(signUpDto.getMemberId())
                .userPw(signUpDto.getUserPw())
                .role(signUpDto.getRole())
                .age(signUpDto.getAge())
                .build();
    }

}
