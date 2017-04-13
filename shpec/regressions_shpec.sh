describe "Regression tests"
    describe "is_function"
        it "returns 0 for function type even for non English locales"
            stub_command "type" "[ \"\$1\" = \"-t\" ] && echo function || echo \"\$2 est une fonction\""
            is_function "custom_assertion"
            assert equal "0" "$?"
            unstub_command "type"
        end

        it "returns 1 for file type"
            is_function "rmdir"
            assert equal "1" "$?"
        end

        it "returns 1 for builtins type"
            is_function "alias"
            assert equal "1" "$?"
        end
    end
end