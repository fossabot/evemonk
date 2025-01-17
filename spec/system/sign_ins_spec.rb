# frozen_string_literal: true

require "rails_helper"

describe "Sign in features" do
  it "when user successfully sign in" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    visit "/sign_in"

    fill_in "sign_in[email]", with: "me@example.com"
    fill_in "sign_in[password]", with: "eidii7EeooVe8ahk"

    click_button "Sign in"

    expect(page).to have_content("Successful signed in!")

    expect(current_path).to eq("/characters")
  end

  it "when user successfully sign in with upper cased email" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    visit "/sign_in"

    fill_in "sign_in[email]", with: "ME@EXAMPLE.COM"
    fill_in "sign_in[password]", with: "eidii7EeooVe8ahk"

    click_button "Sign in"

    expect(page).to have_content("Successful signed in!")

    expect(current_path).to eq("/characters")
  end

  it "when user with given email not found" do
    create(:eve_server_status)

    visit "/sign_in"

    fill_in "sign_in[email]", with: "me@example.com"
    fill_in "sign_in[password]", with: "eidii7EeooVe8ahk"

    click_button "Sign in"

    expect(page).to have_content("Email and/or password is invalid")

    expect(current_path).to eq("/sign_in")
  end

  it "when password wrong" do
    create(:user, email: "me@example.com", password: "eidii7EeooVe8ahk")

    visit "/sign_in"

    fill_in "sign_in[email]", with: "me@example.com"
    fill_in "sign_in[password]", with: "wrong-password"

    click_button "Sign in"

    expect(page).to have_content("Email and/or password is invalid")

    expect(current_path).to eq("/sign_in")
  end
end
