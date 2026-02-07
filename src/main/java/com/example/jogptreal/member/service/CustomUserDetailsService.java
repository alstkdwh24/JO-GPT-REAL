package com.example.jogptreal.member.service;

import com.example.jogptreal.config.dto.CustomUserDetails;
import com.example.jogptreal.member.entity.Members;
import com.example.jogptreal.member.repository.jpa.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {

        Optional<Members> membersOptional = memberRepository.findByMemberId(memberId);

        Members members = membersOptional.orElseThrow(() -> new UsernameNotFoundException("MemberId 가 없습니다."));
        return new CustomUserDetails(members);
    }
}
