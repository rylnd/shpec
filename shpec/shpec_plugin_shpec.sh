describe "shpec plugin"
  case "$SHELL" in
    *zsh)
      . ./shpec.plugin.zsh

      it "defines a shpec alias"
        shpec_type=$(type shpec | cut -d ' ' -f 4)
        assert match ${shpec_type} "alias"
      end

      it "alias that works normaly"
      tmp_spec="/tmp/shpec_shpec_plugin_test" # problems with $(mktemp -q)
        cat > $tmp_spec <<-SHPEC
           describe "Dummy test spec"
             it "Works"; end
           end
SHPEC
         shpec "$tmp_spec" > /dev/null
         assert equal $? 0
       end

       unalias shpec
      ;;

    *)
       it "Zsh specific test, nothing to test for $SHELL"
       end
    ;;
  esac
end
