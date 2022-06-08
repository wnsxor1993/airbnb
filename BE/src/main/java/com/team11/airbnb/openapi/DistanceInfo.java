package com.team11.airbnb.openapi;

import lombok.Getter;

@Getter
public class DistanceInfo {

	private static final int M_TO_KM = 1000;
	private static final int SEC_TO_MIN = 60;

	private final double distanceByKiloMeters;
	private final double timeByMinutes;

	public DistanceInfo(double distanceByMeters, double timeBySeconds) {
		this.distanceByKiloMeters = toKm(distanceByMeters);
		this.timeByMinutes = toMin(timeBySeconds);
	}

	private double toKm(double distanceByMeters) {
		return distanceByMeters / M_TO_KM;
	}

	private double toMin(double timeBySeconds) {
		return timeBySeconds / SEC_TO_MIN;
	}
}
