describe "shell compatibility"
  case "$SHELL" in
    *zsh)
      describe "shpec plugin"
        it "defines a shpec function"
          shpec_type=$(type shpec | cut -d ' ' -f 5)
          assert equal ${shpec_type} "function"
        end

        it "function that works normally"
        tmp_spec="/tmp/shpec_shpec_plugin_test" # problems with $(mktemp -q)
          cat > $tmp_spec <<-SHPEC
             describe "Dummy test spec"
               it "Works"; end
             end
SHPEC
           shpec "$tmp_spec" > /dev/null
           assert equal $? 0
         end
       end
      ;;

    *)
       it "nothing to test for $SHELL"
       end
    ;;
  esac
end
