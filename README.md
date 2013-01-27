# shpec [![Build Status](https://travis-ci.org/rylnd/shpec.png)](https://travis-ci.org/rylnd/shpec)
Test your shell scripts!

## Using shpec
This repo itself is using shpec, so feel free to use it as an example.
Here is the basic structure that you'll want:

    └── shpec
        ├── runner
        ├── shpec
        └── an_example_shpec
        └── another_shpec

with this executable [runner file](https://github.com/rylnd/shpec/tree/master/shpec/runner),
 and of course the [shpec source](https://github.com/rylnd/shpec/tree/master/lib/shpec) itself.

Then to run your tests:

```bash
shpec/runner
```

## Contributing
Pull requests are always welcome.
