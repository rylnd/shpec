shpec [![Build Status](https://travis-ci.org/rylnd/shpec.svg?branch=master)](https://travis-ci.org/rylnd/shpec) [![Join the chat at https://gitter.im/rylnd/shpec](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/rylnd/shpec)
----

*Test your shell scripts!*

<p align='center'>
  <img src='https://raw.github.com/wiki/rylnd/shpec/images/screenshot.png'
       alt="Screenshot of shpec" />
</p>

## Using shpec
This repo itself is using `shpec`, so feel free to use it as an example.
Here is the basic structure that you'll want:

    └── shpec
        └── an_example_shpec.sh
        └── another_shpec.sh

Then to run your tests:

```bash
shpec [shpec_files]
```

If you'd like your tests to run automatically when they change, we recommend the [entr](
http://entrproject.org/) utility:

```bash
find . -name "*_shpec.sh" | entr shpec
```

Note that there are some shell specificities, you'll find more about them in the [Compatibility file](./COMPATIBILITY.md).

### Structuring your Tests
`shpec` is similar to other *BDD* frameworks like
[`RSpec`](
https://github.com/rspec/rspec), [`Jasmine`](
https://github.com/jasmine/jasmine), and [`mocha`](
https://github.com/mochajs/mocha).

The two main constructs are `describe/end` (used to group tests) and `it/end`
(used to describe an individual test and wrap assertions).

__Note:__ Since your test files will be sourced into `shpec`, you can use any
shell command that would normally be available in your session.

### Examples
[shpec's own tests](
https://github.com/rylnd/shpec/tree/master/shpec/shpec_shpec.sh)
are a great place to start. For more examples, see the [wiki page](
https://github.com/rylnd/shpec/wiki/Examples)

### Matchers
The general format of an assertion is:

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

### Stubbing
You can stub commands using `stub_command`.
This function takes the name of the command you wish to stub. If provided,
the second argument will be used as the body of the command. (code that would be evaluated)
Once you're done, you can delete it with `unstub_command`.

The best example is the [shpec test for this feature](
https://github.com/rylnd/shpec/blob/master/shpec/shpec_shpec.sh#L72-L89).
<!-- beware: keep in sync of line when modifying the shpec -->

## Installation
you can either install with curl
```bash
sh -c "`curl -L https://raw.github.com/rylnd/shpec/master/install.sh`"
```

or with [antigen](https://github.com/zsh-users/antigen) for zsh by
putting `antigen bundle rylnd/shpec` in your `.zshrc`

## Contributing
Pull requests are always welcome.

If you've got a test or custom matcher you're particularly proud of,
please consider adding it to [the Examples page](
https://github.com/rylnd/shpec/wiki/Examples)!

### Style and code conventions

#### Language: POSIX shell
The core `shpec` script and function should work the same in
any POSIX compliant shell.  You can use `shpec` to test scripts
that use non-POSIX features, but you must avoid them when extending
`shpec` or the main `shpec_shpech.sh` tests.

#### Namespace
Any variables starting with `_shpec_` are reserved for internal use and
should not be used in test cases (except perhaps for test cases of `shpec`
itself).
