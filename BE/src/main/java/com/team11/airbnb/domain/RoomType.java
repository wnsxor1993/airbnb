package com.team11.airbnb.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum RoomType {
	APARTMENT("아파트"), PRIVATE_ROOM("개인실"), RESIDENCE("레지던스 전체"), SHARE_HOUSE("공동주택 전체");

	private final String type;
}
