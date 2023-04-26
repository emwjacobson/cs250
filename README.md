# Steps

## Clone this repo

```
git clone git@github.com:emwjacobson/cs250.git
cd cs250
```

Unless otherwise mentioned, all future steps should be done within the `cs250` folder.

## Build sample binaries

### Pull and run cb-multios image

```
docker pull hengyin/cb-multios:latest
docker run --rm -it -e BITNESS=64 -e LINK=STATIC -v $(pwd)/binaries:/binaries hengyin/cb-multios:latest
```


### Copy the binaries out

**Inside of container that was started in the previous step,** copy the binaries into the mounted directory.

```
cp -r build/challenges/* /binaries
exit # Quit out of the container
```


### Update permissions

Now outside of the container (and still in the `cs250` folder), update the permissions of the binaries as they are likely owned by `root` from within the container.

```
sudo chown -R YOUR_USERNAME:YOUR_GROUP ./binaries
```

## Fuzzing the Binaries

### Build fuzzing container

This will likely take some time (~30 minutes), as AFL++, SymCC, and SymQEMU are all built from source, and the cloning/building of all of their submodules take a while...

```
docker build -t cs250:latest .
```

### Run fuzzing container

The entrypoint of the container is the `exploit.sh` script located in the `scripts` folder.

#### Interactive Session

An "interactive" session can be started with the following command. Truthfully, though, it isn't super interesting as it just logs which tools have been started.
```
docker run --rm -it -v $(pwd)/binaries:/binaries -v $(pwd)/persistent:/persistent cs250:latest
```

Rather, you can start a backgrounded session using the following command. This is a mostly "hands off" approach, as any relavent files are left in the `persistent` folder for later examination.
```
docker run -d -v $(pwd)/binaries:/binaries -v $(pwd)/persistent:/persistent cs250:latest
```

If you want to check in to see the progress it is making, you can run `docker exec -it CONTAINER_ID bash`, where `CONTAINER_ID` is the ID of the running container. Inside you can run `./afl_check.sh` to get statistics from each instance of AFL++.

Each binary will have a corresponding folder within the `persistent` folder that is mounted inside the container to `/persistent`. Inside of this folder is each of AFL++'s output folders containing runtime stats, inputs that cause crashes/hangs, and any logs related to the tools.
