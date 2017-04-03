describe "shell compatibility"
  case "$SHELL" in
    *zsh)
      describe "shpec plugin"

        . ./shpec.plugin.zsh

        it "defines a shpec alias"
          shpec_type=$(type shpec | cut -d ' ' -f 4)
          assert glob ${shpec_type} "alias"
        end

        it "alias that works normally"
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
       unalias shpec
      ;;

    *)
       it "nothing to test for $SHELL"
       end
    ;;
  esac
end
