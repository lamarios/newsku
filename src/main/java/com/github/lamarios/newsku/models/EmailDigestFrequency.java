package com.github.lamarios.newsku.models;

import static com.github.lamarios.newsku.Constants.ONE_DAY_MS;

public enum EmailDigestFrequency {
  daily(1, "Daily digest"),
  weekly(7, "Weekly digest"),
  monthly(30, "Monthly digest");
  private final int days;
  private final String emailTitle;

  EmailDigestFrequency(int days, String emailTitle) {
    this.days = days;
    this.emailTitle = emailTitle;
  }

  public int getDays() {
    return days;
  }

  public String getEmailTitle() {
    return emailTitle;
  }

  public long getDaysMs() {
    return days * ONE_DAY_MS;
  }
}
