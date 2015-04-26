shpec [![Build Status](https://travis-ci.org/rylnd/shpec.png)](https://travis-ci.org/rylnd/shpec) [![Join the chat at https://gitter.im/rylnd/shpec](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/rylnd/shpec?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
----

Test your shell scripts!

<p align='center'>
  <img src='https://raw.github.com/wiki/rylnd/shpec/images/screenshot.png' alt="Screenshot of shpec" />
</p>

## Using shpec
This repo itself is using shpec, so feel free to use it as an example.
Here is the basic structure that you'll want:

    └── shpec
        └── an_example_shpec.sh
        └── another_shpec.sh

Then to run your tests:

```bash
shpec [shpec_files]
```

If you'd like your tests to run automatically when they change, we recommend the [entr](http://entrproject.org/) utility:

```bash
find . -name "*_shpec.sh" | entr shpec
```

### Examples
[shpec's own tests](https://github.com/rylnd/shpec/tree/master/shpec/shpec_shpec.sh)
are a great place to start. For more examples, see the [wiki page](https://github.com/rylnd/shpec/wiki/Examples)

### Matchers
The general format is:

    assert matcher arguments

where `matcher` is one of the following:

#### Binary Matchers
```bash
equal         # equality
unequal       # inequality
gt            # algebraic '>'
lt            # algebraic '<'
match         # regex match
no_match      # lack of regex match
```

#### Unary Matchers
```bash
present       # string presence
blank         # string absence
file_present  # file presence
file_absent   # file absence
symlink       # tests a symlink's target
test          # evaluates a test string
```

#### Custom Matchers
Custom matchers are loaded from `shpec/matchers/*.sh`.

For example, here's how you'd create a `still_alive` matcher:

```bash
# in shpec/matchers/network.sh
still_alive() {
  ping -oc1 "$1" > /dev/null 2>&1
  assert equal "$?" 0
}
```

Then you can use that matcher like any other:

```bash
# in shpec/network_shpec.sh
describe "my server"
  it "serves responses"
    assert still_alive "my-site.com"
  end
end
```

## Installation
you can either install with curl
```bash
sh -c "`curl -L https://raw.github.com/rylnd/shpec/master/install.sh`"
```

or with [antigen](https://github.com/zsh-users/antigen) for zsh by
putting `antigen bundle rylnd/shpec` in your `.zshrc`

## Contributing
Pull requests are always welcome.

If you've got a test or custom matcher you're particularly proud of, please consider adding it to [the Examples page](https://github.com/rylnd/shpec/wiki/Examples)!

Add your own [Travis status image](http://docs.travis-ci.com/user/status-images/)
to see how your contributions are doing on travis:

AdrieanKhisbe [![build status](
https://travis-ci.org/AdrieanKhisbe/shpec.png
)](https://travis-ci.org/AdrieanKhisbe/shpec
)
hlangeveld [![hlangeveld](
https://travis-ci.org/hlangeveld/shpec.png
)](https://travis-ci.org/hlangeveld/shpec
)
locochris [![build status](
https://travis-ci.org/locochris/shpec.png
)](https://travis-ci.org/locochris/shpec
)

Notes:

 * The release manager may discard or include these upstream at their own discretion)

 * Images for new forks may take up to several minutes to stabilise.
Tracking too many forks might trigger some travis-ci API limit and slow down
the refresh of this README.

