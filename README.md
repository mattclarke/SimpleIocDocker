# SimpleIocDocker
Docker file for creating the [SimpleIoc](https://github.com/mattclarke/SimpleIoc) as a Docker image.

To build the image:
```
sudo docker build -t simpleioc .
```

To run on Linux:
```
sudo docker run --net=host -i simpleioc
```

To run on MacOs:
```
docker run -p 5064:5064 -p 5065:5065 -p 5064:5064/udp -p 5075:5075 -p 5076:5076 -p 5076:5076/udp  -i simpleioc
```
