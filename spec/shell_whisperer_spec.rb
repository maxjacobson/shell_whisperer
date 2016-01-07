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

      it "should expose information about what went wrong" do
        failed = false
        begin
          subject
        rescue ShellWhisperer::CommandFailed => e
          expect(e.original_command).to eq "fafa"
          expect(e.original_message).to match(/fafa/)
          expect(e.exit_code).to eq 127
          failed = true
        end

        expect(failed).to be true
      end
    end
  end
end
