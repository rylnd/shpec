shpec [![Build Status](https://travis-ci.org/shpec/shpec.png)](https://travis-ci.org/shpec/shpec)
----
Test your shell scripts!

<p align='center'>
  <img src='https://raw.github.com/wiki/shpec/shpec/images/screenshot.png' alt="Screenshot of shpec" />
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

### Examples
[shpec's own tests](https://github.com/shpec/shpec/tree/master/shpec/shpec_shpec.sh)
are a great place to start. More detailed examples to come.

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
end_describe
```

## Installation
```bash
sh -c "`curl https://raw.github.com/shpec/shpec/master/install.sh`"
```

## Contributing
Pull requests are always welcome.
