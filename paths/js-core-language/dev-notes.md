# Dev Notes

This is a live document where I will take notes on my development process. The course for this content is Pluralsight's [Javascript Core Language](https://app.pluralsight.com/paths/skill/javascript-core-language) path.

### 7/22/20

* Creating a Docker container to use for this course: 

    `docker run -dt -v /Users/milan/repos/pluralsight:/home/repos/pluralsight -p 5000-6000:5000-6000 --name pluralsight-nodejs ubuntu:focal /bin/bash`
* Getting into the container:
    
    `docker exec -it pluralsight-nodejs /bin/bash`

* Update `apt-get` package manager

    `apt-get update`

* Install `git`

    `apt install git`

* Install curl

    `apt install -y curl`

* Install NodeJS 14.x

    `curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs`

* 