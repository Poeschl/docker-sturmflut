# Sturmflut (Dockerized)

[![](https://img.shields.io/github/license/Poeschl/docker-pixelpwnr.svg?maxAge=3600)](https://github.com/Poeschl/docker-pixelpwnr/blob/master/LICENCE)

A docker container wih the [Sturmflut client](https://github.com/TobleMiner/sturmflut) inside.

# Usage

The contained Strumflut can be used like `docker run -v ./images:/images ghcr.io/poeschl/sturmflut 127.0.0.1 /images/image.png -p 1234 -o 10:20`
to paint `images/image.png` with offset x:10, y:20 towards the pixelflut server on your own machine.
For more options look at [`--help`](https://github.com/TobleMiner/sturmflut#usage).

# Example

An examle docker-compose file can be found in the `/example` folder. Navigate inside it and execute `docker-compose up` to start it.
It floods the Pixelflut server of the rC3 of 2021.

# Licence

The included Sturmflut application is licnces under [MIT License](https://github.com/TobleMiner/sturmflut/blob/master/LICENSE)
