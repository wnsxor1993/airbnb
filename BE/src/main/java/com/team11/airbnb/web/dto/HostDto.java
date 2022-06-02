package com.team11.airbnb.web.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class HostDto {
    private Long id;
    private String name;
    private boolean isSuperHost;
    private String profileImagePath;

}
