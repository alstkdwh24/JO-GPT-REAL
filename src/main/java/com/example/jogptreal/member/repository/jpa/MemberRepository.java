package com.example.jogptreal.member.repository.jpa;

import com.example.jogptreal.member.entity.Members;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Members, Long> {

    boolean existsByMemberId(String memberId);


    Optional<Members> findByMemberId(String memberId);
}
