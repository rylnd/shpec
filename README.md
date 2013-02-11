# shpec [![Build Status](https://travis-ci.org/shpec/shpec.png)](https://travis-ci.org/shpec/shpec)
Test your shell scripts!

### Installation
``` bash
sh -c "`curl https://raw.github.com/shpec/shpec/master/install.sh`"
```

## Using shpec
This repo itself is using shpec, so feel free to use it as an example.
Here is the basic structure that you'll want:

    └── shpec
        └── an_example_shpec.sh
        └── another_shpec.sh

Then to run your tests:

``` bash
shpec [shpec_files]
```

### Examples
Examples to come. In the meantime, check out shpec's
[tests](https://github.com/shpec/shpec/tree/master/shpec/shpec_shpec.sh).

## Contributing
Pull requests are always welcome.
