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

    it "asserts presence"
      assert present "something"
    end

    it "asserts blankness"
      assert blank ""
    end
  end

  describe "equality matcher"
    it "handles newlines properly"
      string_with_newline_char="new\nline"
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

  describe "glob matcher"
    it "is essentially 'assert equal' if no special characters are used"
      assert glob "word" "word"
    end

    it "supports multi-character wildcards"
      assert glob "impartially" "*partial*"
    end

    it "supports single-character wildcards"
      assert glob "word" "wo?d"
      assert no_glob "world" "wo?d"
    end

    it "supports character lists"
      assert glob "foo" "[a-f]oo"
      assert no_glob "foo" "[g-z]oo"
      assert glob "boo" "[a-z]oo"
      assert glob "bar" "[a-z]*"
    end

    it "asserts globs which are not compatible with grep"
      assert glob "loooooooooooooooooong" "l*ng"
    end

    it "asserts lack of globs"
      assert no_glob "zebra" "giraffe"
    end
  end

  describe "grep matcher"
    it "supports matching regular expressions"
      assert grep "hello" "^[a-z]*$"
    end

    it "supports lack of matching regular expressions"
      assert no_grep "hello1" "^[a-z]*$"
    end

    it "does not match multiple lines in a single expression"
      output="$(. $SHPEC_ROOT/etc/multi_assert_example)"

      assert grep "$output" "a assert"
      assert grep "$output" "multi assert"
      assert no_grep "$output" "a assert.*multi assert"
    end
  end

  describe "egrep matcher"
    it "supports matching extended regular expressions"
      assert egrep "hello" "^[a-z]+$"
    end

    it "supports lack of matching extended regular expressions"
      assert no_egrep "hello1" "^[a-z]+$"
    end
  end

  describe "passing through to the test builtin"
    it "asserts an arbitrary algebraic test"
      assert test "[ 5 -lt 10 ]"
    end
  end

  describe "stubbing commands"
    it "stubs to the null command by default"
      stub_command "false"
      false # doesn't do anything
      assert equal "$?" 0
      unstub_command "false"
    end

    it "preserves the original working of the stub"
      false
      assert equal "$?" 1
    end

    it "accepts an optional function body"
      stub_command "curl" "echo 'stubbed body'"
      assert equal "$(curl)" "stubbed body"
      unstub_command "curl"
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
      shpec $SHPEC_ROOT/etc/failing_example > /dev/null 2>& 1
      assert unequal "$?" "0"
    end

    it "returns zero if a suite passes"
      shpec $SHPEC_ROOT/etc/passing_example > /dev/null 2>& 1
      assert equal "$?" "0"
    end
  end

  describe "output"
    it "outputs passing tests to STDOUT"
      message="$(. $SHPEC_ROOT/etc/passing_example)"
      assert grep "$message" "a passing test"
    end

    it "outputs failing tests to STDOUT"
      message="$(. $SHPEC_ROOT/etc/failing_example)"
      assert grep "$message" "a failing test"
    end

    it "joins multiple identical assert names"
      output="$(. $SHPEC_ROOT/etc/multi_assert_example)"

      assert glob "$output" "*a\ assert*multi\ assert*x[0-9]*another\ assert*"
    end

    it "doesn't join FAILED identical assert names"
      output="$(. $SHPEC_ROOT/etc/multi_assert_fail_example)"

      assert glob "$output" "*assert\ with\ errors*assert\ with\ errors*"
      assert grep "$output" "Expected \[1\] to equal \[2\]"
      assert no_grep "$output" "x[0-9]*"
    end
  end

  describe "malformed test files"
    _f=$SHPEC_ROOT/etc/syntax_error

    it "exits with an error"
      shpec $_f > /dev/null 2>& 1
      assert unequal "$?" "0"
    end

    it "informs you of the malformed shpec test file"
      shpec $_f > /tmp/syntax_error_output 2>& 1
      message="$(cat /tmp/syntax_error_output)"
      assert grep "$message" "$_f"
      rm /tmp/syntax_error_output
    end
  end

  describe "commandline arguments"
    describe "multiple arguments"
      it "runs each file passed to the function"
        shpec $SHPEC_ROOT/etc/failing_example $SHPEC_ROOT/etc/passing_example > /dev/null 2>& 1
        assert unequal "$?" "0"

        shpec $SHPEC_ROOT/etc/passing_example $SHPEC_ROOT/etc/failing_example > /dev/null 2>& 1
        assert unequal "$?" "0"
      end
    end

    describe "arguments with whitespace"
      it "runs arguments with spaces"
        shpec "$SHPEC_ROOT/etc/example with spaces" > /tmp/spaces_output 2>& 1
        assert equal "$?" "0"

        output="$(cat /tmp/spaces_output)"

        assert glob "$output" "*a\ test\ file\ with\ spaces*works*"
        rm /tmp/spaces_output
      end

      it "runs multiple arguments with spaces"
        shpec "$SHPEC_ROOT/etc/example with spaces" "$SHPEC_ROOT/etc/example with spaces" > /tmp/multi_spaces_output 2>& 1
        assert equal "$?" "0"

        output="$(cat /tmp/multi_spaces_output)"

        assert glob "$output" "*spaces*works*spaces*works*"
        rm /tmp/multi_spaces_output
      end
    end
  end

  describe "commandline options"
    describe "--version"
      it "outputs the current version number"
        message="$(shpec --version)"
        assert grep "$message" "$(cat $SHPEC_ROOT/../VERSION)"
      end
    end

    describe "-v"
      it "outputs the current version number"
        message="$(shpec -v)"
        assert grep "$message" "$(cat $SHPEC_ROOT/../VERSION)"
      end
    end
  end

  describe "compatibility"
    it "works with old-style syntax"
      message="$(. $SHPEC_ROOT/etc/old_example)"
      assert grep "$message" "old example"
    end
  end
end
