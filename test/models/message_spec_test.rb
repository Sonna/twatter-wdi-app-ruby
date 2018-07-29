# frozen_string_literal: true

require "test_helper"

module Models
  describe Message do
    let :tedd do
      User.create(email: "tedd@test.com", name: "Tedd User", username: "tedd",
                  password: "password")
    end

    let :ursa do
      User.create(email: "ursa@test.com", name: "Ursa User", username: "ursa",
                  password: "password")
    end

    let(:subject) { Message.new(to: tedd, from: ursa, content: "is a test") }

    after do
      tedd.destroy
      ursa.destroy
    end

    describe "when a message is sent from Ursa to Tedd" do
      it("is from Ursa") { expect(subject.from).must_equal(ursa) }
      it("is to Tedd") { expect(subject.to).must_equal(tedd) }
      it("contains content") { expect(subject.content).must_equal("is a test") }
    end
  end
end
