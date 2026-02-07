package com.example.jogptreal.config.dto.social;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor

public class GeneratedToken {
    private String accessToken;
    private Long expiresAt; // 또는 expiresInMs
}
