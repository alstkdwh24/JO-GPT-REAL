package com.example.jogptreal.member.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name="Members")
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Members {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name= "id")
    private Long id;

    @Column(name= "memberId",nullable = false )
    private String memberId;


    @Column(name= "userPw" ,nullable = false)
    private String userPw;

    @Column(name= "name")
    private String name;

    @Column(name = "phone")
    private String phone;

    @Column(name = "role" , nullable = false)
    private Role role;

    @Column(name= "gender")
    private String gender;

    @Column(name = "age")
    private Integer age;


    public String changeMemberId(String memberId) {
        if (memberId != null && !memberId.isEmpty()) {
            this.memberId = memberId;
            return this.memberId;
        }
        return null; // 또는 null
    }

    public String changeUserPw(String userPw) {
        if (userPw != null && !userPw.isEmpty()) {
            this.userPw = userPw;
            return this.userPw;
        }
        return null;
    }

    public String changeGender(String gender) {
        if (gender != null && !gender.isEmpty()) {
            this.gender = gender;
        }
        return null;
    }
    public Integer changeAge(Integer age) {
        if (age != null) {
            this.age = age;
            return this.age;
        }
        return null;
    }

    public Role changeRole(Role role) {
        if (role != null) {
            this.role = role;
            return this.role;
        }
        return null;
    }

    public String changeName(String name) {
        if (name != null && !name.isEmpty()) {
            this.name = name;
            return this.name;
        }
        return null;
    }

    public String changePhone(String phone) {
        if (phone != null && !phone.isEmpty()) {
            this.phone = phone;
            return this.phone;
        }
        return null;
    }
}
