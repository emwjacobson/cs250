# Steps

## Build sample binaries

### Pull and run cb-multios image
```
docker pull hengyin/cb-multios:latest
docker run --rm -it -e BITNESS=64 -e LINK=STATIC -v $(pwd)/binaries:/binaries hengyin/cb-multios:latest
```

### Copy the binaries out
(Inside of container)
```
cp -r build/challenges/* /binaries
```

### Update permissions
(Outside of container)
```
sudo chown -R YOUR_USERNAME:YOUR_GROUP ./binaries
```

## Fuzzing the Binaries

### Build fuzzing container
```
docker build -t cs250:latest .
```

### Run fuzzing container
```
docker run --rm -it -v $(pwd)/binaries:/binaries -v $(pwd)/persistent:/persistent cs250:latest
```

