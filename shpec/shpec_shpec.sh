describe "shpec"
  describe "basic operations"
    it "asserts equality"
      assert equal "foo" "foo"

    it "asserts inequality"
      assert unequal "foo" "bar"

    it "asserts less than"
      assert lt 5 7

    it "asserts greater than"
      assert gt 7 5

    it "asserts partial matches"
      assert match "partially" "partial"

    it "asserts presence"
      assert present "something"

    it "asserts blankness"
      assert blank ""
  end_describe

  describe "passing through to the test builtin"
    it "asserts an arbitrary algebraic test"
      assert test "[[ 5 -lt 10 ]]"
  end_describe

  describe "stubbing commands"
    it "stubs a command to the null command"
      stub_command "exit"
      exit # doesn't really exit
      assert equal "$?" 0
      unstub_command "exit"
  end_describe

  describe "testing files"
    it "asserts file absence"
      assert file_absent /tmp/foo

    it "asserts file existence"
      touch /tmp/foo
      assert file_present /tmp/foo
      rm /tmp/foo

    it "can verify the pointer of a symlink"
      ln -s $HOME /tmp/link
      assert symlink /tmp/link "$HOME"
      rm /tmp/link
  end_describe

  describe "exit codes"
    shpec_cmd="$shpec_root/../bin/shpec"
    it "returns nonzero if any test fails"
      $shpec_cmd $shpec_root/etc/failing_example &> /dev/null
      assert unequal "$?" "0"

    it "returns zero if a suite passes"
      $shpec_cmd $shpec_root/etc/passing_example &> /dev/null
      assert equal "$?" "0"
  end_describe

  describe "output"
    it "outputs passing tests to STDOUT"
      message="$(. $shpec_root/etc/passing_example)"
      assert match "$message" "a\ passing\ test"

    it "outputs failing tests to STDOUT"
      message="$(. $shpec_root/etc/failing_example)"
      assert match "$message" "a\ failing\ test"
  end_describe
end_describe
