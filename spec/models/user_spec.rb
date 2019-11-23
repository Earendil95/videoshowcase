# frozen_string_literal: true

describe User do
  it_validates_presence_of(:email)

  # this spec will check our before_validation callback as well
  specify { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  context "when validating email" do
    subject(:user) { build :user }

    [
      "user@mail.ru",
      "super+man1292@ny.journal.city.ru",
      "best_of_the_best@cryzis.games.state-machine.de"
    ].each do |v|
      it "#{v} is valid" do
        user.email = v
        expect(user).to be_valid
      end
    end

    [
      "ivan",
      "@example.com",
      "user@example.",
      "user@mail.ru@mail.ru",
      "some@",
      ""
    ].each do |v|
      it "#{v} is invalid" do
        user.email = v
        expect(user).not_to be_valid
      end
    end
  end
end
