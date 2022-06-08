package com.team11.airbnb.openapi;

public enum District {
	SEOUL("서울", 126.97857310672501, 37.56654037462486),
	YONGIN("용인",127.17751600488093, 37.2409718113933),
	SUWON("수원", 127.02869106496286, 37.263501338400935),
	GANGRUENG("강릉", 128.8759059060531, 37.752098625346775),
	BUSAN("부산", 129.075073717621, 35.17975315226952),
	JEONJU("전주", 127.14807326809175, 35.82363477515946),
	YEOSU("여수", 127.66230030492281, 34.76021870014728),
	GYEONGJU("경주", 129.22480648691675, 35.8561148324664);

	private String name;
	private double longtitude; //x
	private double latitude; //y

	District(String name, double longtitude, double latitude) {
		this.name = name;
		this.longtitude = longtitude;
		this.latitude = latitude;
	}

	public String getName() {
		return name;
	}

	public double getLongtitude() {
		return longtitude;
	}

	public double getLatitude() {
		return latitude;
	}
}
