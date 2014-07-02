# docker-log-example
This example will show how to view log files of an app running inside a Docker container, using "Volumes". The application here is just a shell script that runs in an infinite loop echoing a string to /var/log/myapp.log

## Building and running the image
First of clone the repo or download the needed files directly then run
   
    docker build -t myimage/logger .

Now you should see a new image with the name you specified with the option -t

    docker images

Let's run it
    
    docker run -d --name "logger" myimage/logger

The option **-d** tells docker to run in the background, in this case it is needed since the "app" runs infinitely and would not give STDIN back.

If everything went well there is a new container called "logger" running the command specified in the Dockerfile. Verify with

    docker ps

## Where are the logs?
Containers are not virtual machines so we can't just easily SSH into the environment, **BUT** there are other ways. In the Dockerfile you see a *VOLUME* instruction that points to */var/log* (obviously, where our logs reside).

    docker inspect -f {{.Volumes}} logger # See where that volume is mapped in the file system

Volumes are not exclusive to containers. Every Docker container is able to connect to a Volume of another container. So let's see how this works by spawning a new one.

    docker run -t -i --volumes-from=logger --name logview ubuntu:14.04 /bin/bash # running Ubuntu here because it is the base immage

The option **--volumes-from=** does the magic of connecting the Volumes from another container. After running the above command you should have a shell and can access the logs of our "application".

    tail -f /var/log/myapp.log

## Use Cases
- Accessing log files (as in the example above)
- running backups
- share data between containers

## Further reading
The example was inspired by this blog post <http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/> There you will also find a way to actually get a shell in a running container by using [nsenter](https://github.com/jpetazzo/nsenter).




