package com.example.jogptreal.member.dto.request;

import com.example.jogptreal.member.entity.Role;
import jakarta.persistence.Column;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignUpDto {
    private Long id;

    private String memberId;
    private String name;

    private String userPw;

    private String phone;

    private Role role;

    private String gender;

    private int age;


}
