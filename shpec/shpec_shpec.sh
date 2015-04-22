describe "shpec"
  describe "basic operations"
    it "asserts equality"
      assert equal "foo" "foo"
    end

    it "asserts inequality"
      assert unequal "foo" "bar"
    end

    it "asserts less than"
      assert lt 5 7
    end

    it "asserts greater than"
      assert gt 7 5
    end

    it "asserts partial matches"
      assert match "partially" "partial"
    end

    it "asserts lack of partial matches"
      assert no_match "zebra" "giraffe"
    end

    it "asserts presence"
      assert present "something"
    end

    it "asserts blankness"
      assert blank ""
    end
  end

  describe "equality matcher"
    it "handles newlines properly"
      string_with_newline_char="new
line"
      multiline_string='new
line'
      assert equal "$multiline_string" "$string_with_newline_char"
    end

    it "compares strings containing single quotes"
      assert equal "a' b" "a' b"
    end

    it "compares strings containing double quotes"
      assert equal 'a" b' 'a" b'
    end
  end

  describe "lt matcher"
    it "handles numbers of different length properly"
      assert lt 5 17
    end
  end

  describe "gt matcher"
    it "handles numbers of different length properly"
      assert gt 17 5
    end
  end

  describe "passing through to the test builtin"
    it "asserts an arbitrary algebraic test"
      assert test "[ 5 -lt 10 ]"
    end
  end

  describe "'stub_command'"
    it "defaults to the null command"
      stub_command "false"
      false # doesn't do anything
      assert equal "$?" 0
    end
    it "accepts an optional function body"
      stub_command "curl" "echo 'stubbed body'"
      assert equal "$(curl)" "stubbed body"
      unstub_command "curl"
    end
  end
  describe "'unstub_command'"
    it "restores the original working"
      unstub_command "false"
      (false) || _r=$?
      assert equal "$_r" 1
    end
  end

  describe "testing files"
    it "asserts file absence"
      assert file_absent /tmp/foo
    end

    it "asserts file existence"
      touch /tmp/foo
      assert file_present /tmp/foo
      rm /tmp/foo
    end

    it "can verify the pointer of a symlink"
      ln -s $HOME /tmp/link
      assert symlink /tmp/link "$HOME"
      rm /tmp/link
    end
  end

  describe "custom matcher"
    it "allows custom matchers"
      assert custom_assertion "argument"
    end
  end

  describe "exit codes"
    it "returns nonzero if any test fails"
      shpec $SHPEC_ROOT/etc/failing_example > /dev/null 2>& 1 || _r=$?
      assert unequal "$_r" "0"
    end

    it "returns zero if a suite passes"
      shpec $SHPEC_ROOT/etc/passing_example > /dev/null 2>& 1
      assert equal "$?" "0"
    end
  end

  describe "output"
    it "outputs passing tests to STDOUT"
      message=$(. $SHPEC_ROOT/etc/passing_example)
      assert match "$message" "a\ passing\ test"
    end

    it "outputs failing tests to STDOUT"
      message=$(. $SHPEC_ROOT/etc/failing_example)
      assert match "$message" "a\ failing\ test"
    end
  end

  describe "commandline options"
    _version=$(cat $SHPEC_ROOT/../VERSION)
    describe "--version"
      it "outputs the current version number"
        message=$( shpec --version )
        assert match "$message" "$_version"
      end
    end

    describe "-v"
      it "outputs the current version number"
        message=$( shpec -v )
        assert match "$message" "$_version"
      end
    end
  end

  describe "compatibility"
    it "works with old-style syntax"
      message=$(. $SHPEC_ROOT/etc/old_example)
      assert match "$message" "old\ example"
    end
  end

  describe "skip_next_assert"
    it "skips this failing test"
      skip_next_assert
      assert fail
    end
  end

  describe "fail"
    it "fails this test (EXPECTED)"
      assert fail
    end
  end
end
