# shpec [![Build Status](https://travis-ci.org/rylnd/shpec.png)](https://travis-ci.org/rylnd/shpec)
Test your shell scripts!

## Using shpec
This repo itself is using shpec, so feel free to use it as an example.
Here is the basic structure that you'll want:

    ├── bin
        └── shpec
    └── shpec
        └── an_example_shpec
        └── another_shpec

with the executable [shpec file](https://github.com/rylnd/shpec/tree/master/bin/shpec) in `bin/`.

Then to run your tests:

```bash
bin/shpec [shpec_files]
```

### Examples
Examples to come. In the meantime, check out shpec's
[tests](https://github.com/rylnd/shpec/tree/master/shpec/shpec_shpec).

## Contributing
Pull requests are always welcome.
