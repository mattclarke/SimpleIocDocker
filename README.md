# SimpleIocDocker
Docker file for creating the [SimpleIoc](https://github.com/mattclarke/SimpleIoc)

To build the image:
```
sudo docker build -t simpleioc .
```

To run:
```
sudo docker run --net=host -i simpleioc
```
