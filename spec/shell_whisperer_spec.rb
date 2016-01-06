require "spec_helper"

describe ShellWhisperer do
  it "has a version number" do
    expect(ShellWhisperer::VERSION).not_to be nil
  end

  describe "::run" do
    context "when the command ought to succeed" do
      subject { described_class.run("ls").split("\n") }
      it { is_expected.to be_a Array }
      it { is_expected.to include "README.md" }
    end

    context "when the command ought to fail" do
      subject { described_class.run("fafa") }
      it "should fail" do
        expect { subject }.to raise_error(ShellWhisperer::CommandFailed, /fafa/)
      end
    end
  end
end
